from flask import Flask, render_template, url_for, request, redirect, flash,session
from flask_mysqldb import MySQL,MySQLdb
import bcrypt
from flask_cors import CORS,cross_origin
from flask import jsonify
import json
app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '12300321mk'
app.config['MYSQL_DB'] = 'recturedb'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
mysql= MySQL(app)
CORS(app)
app.secret_key='Recture'



@app.route('/deneme',methods=['GET','POST'])
def deneme():
    response = jsonify(message="Simple server is running")
    response.headers.add("Access-Control-Allow-Origin", "*")
    
    return response

@app.route('/sign_up', methods=['GET','POST'])
def sign_up():
    data = json.loads(request.data.decode())
    userinfo=data['userInfo']
    userType = "nonPremium"
    name = userinfo['firstName']
    surname = userinfo['lastName']
    username = userinfo['username']
    password = userinfo['password'].encode('utf-8')
    hash_password = bcrypt.hashpw(password,bcrypt.gensalt())
    email = userinfo['email']
    img = data['image']
    
    cur = mysql.connection.cursor()
    cur.execute('INSERT INTO user (name,surname,username,userType,password,email,ImageUrl) VALUES(%s,%s,%s,%s,%s,%s,%s)',
    (name,surname,username,userType,hash_password,email,img))
    mysql.connection.commit()
    cur.execute("SELECT * FROM user WHERE username=%s",(username,))
    user = cur.fetchone()
    cur.close()
    response = jsonify(user)  # sign up işleminden sonra neden bilgi yolluyorum?????????????
    return response


@app.route('/sign_in',methods=['GET','POST'])
def sign_in():
    error = jsonify(error='Invalid password') 
    error2 = jsonify(error='User not found') 
    data = json.loads(request.data.decode())
    username = data['username']
    password = data['password'].encode('utf-8')
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT * FROM user WHERE username=%s",(username,))
    user = cur.fetchone()
    cur.close()
    if user:
        if  bcrypt.hashpw(password,user['password'].encode('utf-8')) == user['password'].encode('utf-8'):
            response = jsonify(user)  
            return response
        else:
            return error
    else:
        return error2
if __name__ == "__main__":
    app.run(debug=True)