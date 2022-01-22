from flask import Flask, request, jsonify
import simplejson as json
from flask_cors import CORS
from flask_mysqldb import MySQL
import os
import uuid
import yaml
from werkzeug.utils import secure_filename
import mysql.connector
import datetime


app = Flask(__name__)
CORS(app, resources={r"/*":{"origins": ["http://localhost:*", "http://127.0.0.1:*"]}})
# DB Configuration
db = yaml.load(open('db.yaml'))
# app.config['MYSQL_HOST'] = db['MYSQL_HOST']
# app.config['MYSQL_USER'] = db['MYSQL_USER']
# app.config['MYSQL_PASSWORD'] = db['MYSQL_PASSWORD']
# app.config['MYSQL_DB'] = db['MYSQL_DB']

MYSQL_HOST = db['MYSQL_HOST']
MYSQL_USER = db['MYSQL_USER']
MYSQL_PASSWORD = db['MYSQL_PASSWORD']
MYSQL_DB = db['MYSQL_DB']
conn = mysql.connector.connect(host=MYSQL_HOST,
                               database=MYSQL_DB,
                               user=MYSQL_USER,
                               password=MYSQL_PASSWORD)

UPLOAD_FOLDER = 'C:/Users/91628/Downloads/add-to-cart-master/add-to-cart-master/src/assets'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
# mysql = MySQL(app)
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])

def allowed_file(filename):
	return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def convertToBinary(file):
    with open(file, 'rb'):
        binData = file.read()
    return binData

def binaryToFile(binData, fileName):
    with open(fileName, 'wb') as file:
        file.write(binData)

@app.route('/register', methods=['GET','POST'])
def register():
    print("Register")
    if request.method == 'POST':
        content = request.get_json()
        data = (content["first_name"],content["last_name"],content["email"],content["password"])
        try:
            cur = conn.cursor(buffered=True)
            cur.execute("Insert into customers(first_name, last_name, email_address,password)  VALUES (%s,%s,%s,%s)", data )
            conn.commit()
            cur.close()
            resp = {
                "status_code" :200,
                "message": "Success"
            }
            return json.dumps(resp)
        except:
            print("Something went wrong")

    resp = {
        "status_code": 500,
        "message": "Something went wrong"
    }
    return json.dumps(resp)


@app.route('/products', methods=['GET','POST'])
def getProducts():
    if request.method == 'GET':
        cur = conn.cursor(buffered=True)
        cur.execute("Select product_id, category_id, product_name, description, list_price,image from products")
        res = [{ "product_id": row[0], "category_id": row[1], "product_name": row[2], "description":row[3], "price": row[4], "image": row[5]} for row in cur]
        cur.close()
        return json.dumps(res)

@app.route('/categories', methods=['GET','POST'])
def categories():
    if request.method == 'GET':
        curr = conn.cursor(buffered=True)
        curr.execute("Select category_id, category_name, image from categories")
        res = [{ "category_id": row[0], "category_name": row[1], "image": (UPLOAD_FOLDER+"/"+(row[2] or ''))} for row in curr]
        curr.close()
        return json.dumps(res)

@app.route('/login', methods=['GET','POST'])
def login():

    if request.method == 'POST':
        result = -999
        output = ""
        user = request.form["username"]
        passw = request.form["password"]
        cur = conn.cursor(buffered=True)
        cur.execute("Select customer_id, email_address, password, root_access from customers where email_address=%s", (user,))
        if cur.rowcount == 0:
            resp = {
                "result": -1,
                "data": "Email doesn't exist"
            }
            return json.dumps(resp)
        else:
            res = cur.fetchone()
            res_output= {"customer_id": res[0], "email": res[1],  "root_access": res[3]}
            if passw == res[2]:
                resp = {
                    "result": 1,
                    "data": res_output
                }
                return json.dumps(resp)
            else:
                resp = {
                    "result": 0,
                    "data": "Incorrect username or email"
                }
                return json.dumps(resp)


@app.route('/addCategory', methods=['GET','POST'])
def addCategory():
    if request.method == 'POST':
        img=''
        try:
            img = request.files["image"]
        except:
            pass
        catName = request.form["categoryName"]
        # pic = convertToBinary(img)
        # print(type(pic))
        print(catName, " ......", type(img))
        if img and allowed_file(img.filename):
            filename = secure_filename(img.filename)
            print(os.path)
            # Picture = digital_to_binary(image
            img.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            print('upload_image filename: ' + filename)
            cur = conn.cursor()
            cur.execute("Insert into categories(category_name,image) VALUES(%s,%s)",(catName, filename))
            conn.commit()
            cur.close()

    return json.dumps(True)

@app.route('/addProduct', methods=['GET','POST'])
def addProducts():
    if request.method == 'POST':
        img = ''
        try:
            img = request.files["image"]
        except:
            pass
        name = request.form["name"]
        code = request.form["code"]
        description = request.form["description"]
        price = request.form["price"]
        category = request.form["category"]
        if img and allowed_file(img.filename):
            filename = secure_filename(img.filename)
            print(os.path)
            # Picture = digital_to_binary(image
            img.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            print('upload_image filename: ' + filename)
            cur = conn.cursor()
            cur.execute(
                "Insert into products (category_id,product_code,product_name,description,list_price,image) VALUES(%s,%s,%s,%s,%s,%s)",
                (category, code, name, description, price, filename))

            conn.commit()
            cur.close()

    return json.dumps(True)


@app.route('/checkOut', methods=['GET','POST'])
def checkOut():
    if request.method == 'POST':
        customerData = request.get_json()["customerData"]
        productsData = request.get_json()["productsData"]
        cust_id = request.get_json()["cust_id"]
        total=request.get_json()["grandTotal"]
        values = [cust_id]
        values.extend( [d for k,d in customerData.items()])
        values = tuple(values)

        cur = conn.cursor(buffered=True)
        cur.execute("Insert into addresses(customer_id, line1, line2,city,state, zip_code,phone)  VALUES (%s,%s,%s,%s,%s,%s,%s)",
                    values)
        conn.commit()

        cur.execute("Select max(address_id)+1 from addresses")
        address_id = cur.fetchone()[0]
        cur.execute("Insert into orders_ecom(customer_id,order_total,ship_address_id) VALUES (%s,%s,%s)",(cust_id,total,address_id))
        conn.commit()

        cur.execute("Select max(order_id) from orders_ecom")
        order_id = cur.fetchone()[0]
        order_items = []
        for i in productsData:
            global found
            found = False
            for k in order_items:
                if i["product_id"] == k["product_id"]:
                    found = True
                    k["quantity"] = k["quantity"] + 1
            if not found:
                order_items.append(i)
        # print(order_items)


        print(order_id)
        for item in order_items:
            cur.execute("Insert into order_items(order_id,product_id,item_price,quantity) VALUES (%s,%s,%s,%s)",
                        (order_id, item["product_id"], item["price"], item["quantity"]))
        conn.commit()

        cur.close()
        resp = {
            "status_code": 200,
            "message": "Success"
        }
        return json.dumps(resp)





@app.route('/orderHistory', methods=['GET','POST'])
def getOrderHistory():
    if request.method == 'GET':
        cur = conn.cursor(buffered=True)
        query = "Select  o.order_id, order_total,  date_format(order_date, '%d %m %y'), oi.product_id, product_name, item_price, quantity, customer_id " \
        "FROM  orders_ecom as o " \
        "JOIN order_items  as oi " \
        "ON o.order_id = oi.order_id " \
        "JOIN products as p " \
        "ON p.product_id = oi.product_id "
        cur.execute(query)
        allRows = cur.fetchall()
        data = []
        for row in allRows:
            row_content = {
                "order_id": row[0],
                "order_total": row[1],
                "order_date": row[2],
                "product_id": row[3],
                "product_name": row[4],
                "item_price": row[5],
                "quantity": row[6],
                "customer_id": row[7]
            }
            print(row_content)
            data.append(row_content)
    return json.dumps(data)
    # print(row_content)




# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    app.run(debug=True)

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
