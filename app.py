from flask import Flask, request, jsonify
import simplejson as json
from flask_cors import CORS
from flask_mysqldb import MySQL
import os
import uuid
import yaml
from werkzeug.utils import secure_filename

app = Flask(__name__)
CORS(app, resources={r"/*":{"origins": ["http://localhost:*", "http://127.0.0.1:*"]}})
# DB Configuration
db = yaml.load(open('db.yaml '))
app.config['MYSQL_HOST'] = db['MYSQL_HOST']
app.config['MYSQL_USER'] = db['MYSQL_USER']
app.config['MYSQL_PASSWORD'] = db['MYSQL_PASSWORD']
app.config['MYSQL_DB'] = db['MYSQL_DB']
UPLOAD_FOLDER = 'static/uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
mysql = MySQL(app)
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

@app.route('/categories', methods=['GET','POST'])
def health():
    if request.method == 'GET':
        cur = mysql.connection.cursor()
        cur.execute("Select product_id, category_id, product_name, description, list_price from products")
        res = [{ "product_id": row[0], "category_id": row[1], "product_name": row[2], "description":row[3], "price": row[4]} for row in cur]
        cur.close()
        return json.dumps(res)

@app.route('/login', methods=['GET','POST'])
def login():
    if request.method == 'POST':
        user = request.form["username"]
        passw = request.form["password"]
        cur = mysql.connection.cursor()
        cur.execute("Select * from cred where email=%s", (user,))
        if cur.rowcount == 0:
            return json.dumps({
                "result": -1,
                "data": "Email doesn't exist"})

        else:
            res = cur.fetchone()
            result = {"email": res[0],  "root_access": res[2]}
            if passw == res[1]:
                return json.dumps({
                    "result": 1,
                    "data": result})
            else:
                return json.dumps({
                    "result": 0,
                    "data": "Incorrect username or email"})
        return json.dumps(True)

@app.route('/addCategory', methods=['GET','POST'])
def addCategory():
    if request.method == 'POST':
        print("+++++++++++++++++++++++++")
        img=''
        try:
            img = request.files["image"]
        except:
            pass
        catName = request.form["categoryName"]
        pic = convertToBinary(img)
        print(type(pic))
        print(catName, " ......", type(img))
        if img and allowed_file(img.filename):
            filename = secure_filename(img.filename)
            print(os.path)
            # Picture = digital_to_binary(image
            # img.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            # print('upload_image filename: ' + filename)
            # flash('Image successfully uploaded and displayed below')
        #     return render_template('upload.html', filename=filename)
        # else:
        #     flash('Allowed image types are -> png, jpg, jpeg, gif')
        #     return redirect(request.url)
        # values = ()
        # cur = mysql.connection.cursor()
        # cur.execute("Insert into from categories(category_name,image) VALUES(%s,%s)",(catName, pic,))

    return json.dumps(True)
# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    app.run(debug=True)

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
