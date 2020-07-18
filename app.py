from flask import Flask,request,jsonify,json,render_template,redirect,session
from ast import literal_eval
import requests
import pymysql
from urllib.parse import urlencode
import datetime
import hashlib
import datetime

app = Flask(__name__)


'''Basic Data needed'''
app.secret_key = '_5#y2L"F4Q8dATabASe64OOtEaMOi0]/'
server = "http://127.0.0.1:5000"


try:
    from db_account_config_local import db_args, db_argv
except:
    from db_account_config import db_args, db_argv

db = pymysql.connect(*db_args, **db_argv)

# Caching options for ESF, Declarations, Incidents, TimeUnit
# during login session. When nocache is false, if one of these
# is changed outside the application during a session, user
# should login again to get updated data.
NOCACHE = True

'''Data Parsing'''
def extract(form, *keys):
    '''Extract specified keys and values to construct F from form'''
    if not keys:
        return form.to_dict()
    F = {}
    for k in keys:
        F[k] = form.get(k)
    return F

def callproc_with_result(cursor, proc, args, result):
    cursor.callproc(proc, args)
    return cursor.execute('SELECT * FROM `{}`'.format(result))

@app.route('/logout')
def logout():
    print(">>> Entering logout", session)
    session.clear()
    return redirect('/login.html')    

@app.route("/getCOMPANY")
def getCOMPANY():
    cursor = db.cursor()
    sql = "SELECT compname FROM COMPANY"
    result = {}
    try:
        # Execute the SQL command
        print(sql)
        cursor.execute(sql)
        # Fetch all the rows in a list of lists.
        temp = cursor.fetchall()
        print("success!!!!")
        data = []
        for n in range(0, len(temp)):
            data.append(temp[n][0])
    except pymysql.err.ProgrammingError:
        print("Error: unable to fetch data")
        data = []
    if data is None:
        data = []
    print("!!!")
    return data
    
@app.route("/getMANAGER_AVAILABLE")
def getMANAGER_AVAILABLE():
    cursor = db.cursor()
    sql = "select username from manager left join theater on manager.username = theater.manageby where theaname is null"
    result = {}
    try:
        # Execute the SQL command
        print(sql)
        cursor.execute(sql)
        # Fetch all the rows in a list of lists.
        temp = cursor.fetchall()
        data = []
        for n in range(0, len(temp)):
            data.append(temp[n][0])
        print(data)
    except pymysql.err.ProgrammingError:
        print("Error: unable to fetch data")
        data = []
    if data is None:
        data = []
    return data

@app.route("/getSTATE")
def getSTATE():
    cursor = db.cursor()
    sql = "SELECT DISTINCT state FROM theater"
    result = {}
    try:
        # Execute the SQL command
        print(sql)
        cursor.execute(sql)
        # Fetch all the rows in a list of lists.
        data = cursor.fetchall()
        data_2 = []
        for i in range(len(data)):
            data_2.append(data[i][0])
            # print("length:", data[i][0])
        print("success!!!!")
        print("state:", data_2)
    except pymysql.err.ProgrammingError:
        print("Error: unable to fetch data")
        data = []
    if data is None:
        data = []
    print("!!!")
    ##session['COMPANY']=data
    return data_2

@app.route("/getMOVIE")
def getMOVIE():
    cursor = db.cursor()
    sql = "SELECT moviename FROM MOVIE"
    result = {}
    try:
        # Execute the SQL command
        print(sql)
        cursor.execute(sql)
        # Fetch all the rows in a list of lists.
        data = cursor.fetchall()
        data_2 = ['ALL']
        for i in range(len(data)):
            data_2.append(data[i][0])
            # print("length:", type(data))
        print("success!!!!")
        print("MOVIE DATA:", data_2)
    except pymysql.err.ProgrammingError:
        print("Error: unable to fetch data")
        data = []
    if data is None:
        data = []
    print("!!!")
    ##session['COMPANY']=data
    return data_2

@app.route("/getTHEATER")
def getTHEATER():
    cursor = db.cursor()
    sql = "SELECT DISTINCT theaname FROM theater"
    result = {}
    try:
        # Execute the SQL command
        print(sql)
        cursor.execute(sql)
        # Fetch all the rows in a list of lists.
        data = cursor.fetchall()
        data_2 = ['ALL']
        for i in range(len(data)):
            data_2.append(data[i][0])
            # print("length:", data[i][0])
        print("success!!!!")
        print("state:", data_2)
    except pymysql.err.ProgrammingError:
        print("Error: unable to fetch data")
        data = []
    if data is None:
        data = []
    print("!!!")
    ##session['COMPANY']=data
    return data_2

#screen register_successfully
@app.route("/register_successfully.html", methods=['GET','POST'])
def register_successfully():
    return render_template("register_successfully.html")

  
#screen excuete_successfully
@app.route("/excuete_successfully.html", methods=['GET','POST'])
def excuete_successfully():
    if 'username' not in session:
        return redirect("login.html")
    return render_template("excuete_successfully.html")  

#screen manager_theater_overview_results
@app.route("/manager_theater_overview_results.html", methods=['GET','POST'])
def manager_theater_overview_results():
    if 'username' not in session:
        return redirect("login.html")
    manager_theater_overview_results = []
    manager_theater_overview_results.append(session['movName'])
    manager_theater_overview_results.append(session['movDuration'])
    manager_theater_overview_results.append(session['movReleaseDate'])
    manager_theater_overview_results.append(session['movPlayDate'])
    return render_template("manager_theater_overview_results.html", manager_theater_overview_results = manager_theater_overview_results)

#screen admin_manage_user_results
@app.route("/admin_manage_user_results.html", methods=['GET','POST'])
def admin_manage_user_results():
    if 'username' not in session:
        return redirect("login.html")
    #print(">>> Entering admin_manage_user_results page", session)

    admin_manage_user_results = []
    admin_manage_user_results.append(session['admin_manage_user_username'])
    admin_manage_user_results.append(session['creditCardCount'])
    admin_manage_user_results.append(session['userType'])
    admin_manage_user_results.append(session['status'])
    print("!!!!!hhhhhh")
    print(admin_manage_user_results)
    print(session['admin_manage_user_username'])
    render_template("admin_manage_user_results.html", admin_manage_user_results = admin_manage_user_results)

    if request.method == "POST":
        
        F = extract(request.form)
        print('F')
        print(F)
        print(len(F))

        # if not (0 < len(F['username']) <= 45 and 0 < len(F['password']) <= 200
        #         and 0 < len(F['firstname']) <= 45 and 0 < len(F['lastname']) <= 45
        #         and N >= 1 and N <= 5):
        #     print("Invalid username or password or firstname or lastname or creditcardnum")

        cursor = db.cursor()
        # print('includeNotPlayed: ')
        # print(F['includeNotPlayed'])
        print(type(F['username']))
        print("select status from user where username = {}".format(F['username']))
        cursor.execute("select status from user where username = '{}'".format(F['username']))
        status = cursor.fetchone()
        print("status",status[0])



        print(status)
        print(type(status))
        print("seeedecline!!")
        #print(F['Decline'])
        try:
            if 'Approve' in F:
                #print("hahahhahaapprove!!!")
                
                cursor.callproc('admin_approve_user', [F['username']])
            if 'Decline' in F:
                print("hahahhahaapprove!!!")
                if status[0] == 'Approved':
                    print('Invalid operation. You can not decline "approved" user!')
                    return 'Invalid operation. You can not decline "approved" user!'
                cursor.callproc('admin_decline_user', [F['username']])
        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)
        return render_template("admin_manage_user_results.html", admin_manage_user_results = admin_manage_user_results)
        #return redirect("admin_manage_user.html")

        
    return render_template("admin_manage_user_results.html", admin_manage_user_results = admin_manage_user_results)






'''Session validation'''
# Screen 1
@app.route("/login.html", methods=['GET', 'POST'])
def login():
    print(">>> Entering login page", session)
    if request.method == "POST":
        F = extract(request.form)
        if not(0 < len(F['username']) <= 45 and 0 < len(F['password']) <= 200):
            print("Invalid username or password")

        cursor = db.cursor()

        try:
            a=F['password']
            m=hashlib.md5()
            m.update(a.encode(encoding='utf-8'))
            password_md5=m.hexdigest()
            
            # Execute the stored procedure:
            callproc_with_result(cursor, 'user_login',
                [F['username'], password_md5],
                'UserLogin')
            # Fetch all the rows in a list of lists.
            data = cursor.fetchone()
            print("the following is the output of screen1")
            print(data)
            print("#####")
            print(data[3])
            username, status, cust, admin, mgr = data

            if data:
                session['username'] = username
                print(session)
                # return str(data)
            else:
                return "Login failed"
            if data[2]=='0' and data[3]=='1' and data[4]=='0':
                return redirect("admin_only_functionality.html")
            elif data[2]=='1' and data[3]=='1' and data[4]=='0':
                return redirect("admin_customer_functionality.html")
            elif data[2]=='0' and data[3]=='0' and data[4]=='1':
                return redirect("manager_only_functionality.html")
            elif data[2]=='1' and data[3]=='0' and data[4]=='1':
                return redirect("manager_customer_functionality.html")
            elif data[2]=='1' and data[3]=='0' and data[4]=='0':
                return redirect("customer_functionality.html")
            elif data[2]=='0' and data[3]=='0' and data[4]=='0':
                return redirect("user_functionality.html")
            

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to fetch data", e)
            

        #上面是读取db
        #下面是处理data

    else:
        session.clear()
    # return render_template("login.html",username = session['username'])
    return render_template("login.html")

#screen 2
@app.route("/register_navigation.html", methods=['GET','POST'])
def register_navigation():
    return render_template("register_navigation.html")


# Screen 3
@app.route("/user_registration.html", methods=['GET','POST'])
def user_registration():
    print(">>> Entering user_registration.html", session)
    if request.method == "POST":
        print("yes")
        F = extract(request.form)
        if not(0 < len(F['username']) <= 45 and 0 < len(F['password']) <= 200
            and 0 < len(F['firstname']) <= 45 and 0 < len(F['lastname']) <= 45):
            print("Invalid username or password or firstname or lastname")
        
        cursor = db.cursor()

        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))


            cursor.callproc('user_register', [F['username'], F['password'], 
            F['firstname'],F['lastname']])
            print("successfully login!!!")
            return redirect("register_successfully.html")
        except pymysql.err.IntegrityError as e1:
            return "user register failed(username exists)"

        # except pymysql.err.ProgrammingError as e:
        #     print("Error: unable to insert user registration data", e)

    return render_template("user_registration.html")


    

# Screen 4
@app.route("/customer_only_registration.html", methods=['POST','GET'])
def customer_only_registration():
    print(">>> Entering login page", session)
    if request.method == "POST":
        F = extract(request.form)



        if not(0 < len(F['firstname']) <= 45 and 0 < len(F['lastname']) <= 45):
            return 'Sorry, firstname or lastname is too long (max length = 45). Registration failed. Please register again.'
        
        if not(0 < len(F['username']) <= 45):
            return 'Sorry, username is too long (max length = 45). Registration failed. Please register again.'
        
        
        if not (0 < len(F['password']) <= 200 and 0 <= len(F['confirmpassword']) <= 200):
            return 'Sorry, passward is too long (max length = 200). Registration failed. Please register again.'

        if not (F['password'] == F['confirmpassword']):
            return 'Sorry, passwords are not consistent. Registration failed. Please register again.'
        list_credit = []
        
        if not (15 <= len(F['creditcardnum1']) <= 16):
            return 'Sorry, creditcard1 is not a valid card. Registration failed. Please register again.'
        list_credit.append(F['creditcardnum1'])
        if F['creditcardnum2']:
            if not (15 <= len(F['creditcardnum2']) <= 16):
                return 'Sorry, creditcard2 is not a valid card. Registration failed. Please register again.'
            list_credit.append(F['creditcardnum2'])
        if F['creditcardnum3']:
            if not (15 <= len(F['creditcardnum3']) <= 16):
                return 'Sorry, creditcard3 is not a valid card. Registration failed. Please register again.'
            list_credit.append(F['creditcardnum3'])
        if F['creditcardnum4']:
            if not (15 <= len(F['creditcardnum4']) <= 16):
                return 'Sorry, creditcard4 is not a valid card. Registration failed. Please register again.'
            list_credit.append(F['creditcardnum4'])
        if F['creditcardnum5']:
            if not (15 <= len(F['creditcardnum5']) <= 16):
                return 'Sorry, creditcard5 is not a valid card. Registration failed. Please register again.'
            list_credit.append(F['creditcardnum5'])
        
        N = len(list_credit)

        cursor = db.cursor()

        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))


            cursor.callproc('customer_only_register', [F['username'], F['password'], 
            F['firstname'],F['lastname']])
            for i in range(N):
                cursor.callproc('customer_add_creditcard', [F['username'],list_credit[i]])


            print("customer_only_registration successfully!!!")
            return redirect("register_successfully.html")

        
        except pymysql.err.IntegrityError as e1:
            return "user register failed(username exists)"

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)

    return render_template("customer_only_registration.html")


# Screen 5
@app.route("/manager_only_registration.html", methods=['GET','POST'])
def manager_only_registration():
    print(">>> Entering register page", session)
    if request.method == "POST":
        F = extract(request.form)

        cursor = db.cursor()

        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))
            
            print("let's test company information")
            print(F['comName'])
            print(len(F['comName']))
            cursor.callproc('manager_only_register', [F['username'], F['password'], 
                F['firstname'],F['lastname'],F['comName'], F['empStreet'], 
                F['empCity'], F['empState'],F['empZipcode']])
            return redirect("register_successfully.html")
        
        # except pymysql.err.IntegrityError as e1:
        #     return "user register failed(username exists)"

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)
    print("AAA")
    COMPANY=getCOMPANY()
    session['COMPANY']=COMPANY
    # COMPANY_2=list(list(i) for i in COMPANY)
    # for i in COMPANY_2:
        # print(len(i))
    # session['COMPANY']=COMPANY_2
    # print("in screen 5")
    # print(type(COMPANY_2))
    return render_template("manager_only_registration.html",**extract(session,'COMPANY'))



# Screen 6
@app.route("/manager_customer_registration.html", methods=['POST','GET'])
def manager_customer_registration():
    print(">>> Entering login page", session)
    if request.method == "POST":
        F = extract(request.form)
        if not(0 < len(F['firstname']) <= 45 and 0 < len(F['lastname']) <= 45):
            return 'Sorry, firstname or lastname is too long (max length = 45). Registration failed. Please register again.'
        
        if not(0 < len(F['username']) <= 45):
            return 'Sorry, username is too long (max length = 45). Registration failed. Please register again.'
        if not(0 < len(F['empStreet']) <= 100):
            return 'Sorry, Street is too long (max length = 100). Registration failed. Please register again.'

        if not(0 < len(F['empCity']) <= 45):
            return 'Sorry, Street is too long (max length = 45). Registration failed. Please register again.'
        
        if not (0 < len(F['password']) <= 200 and 0 <= len(F['confirmpassword']) <= 200):
            return 'Sorry, passward is too long (max length = 200). Registration failed. Please register again.'

        if not (F['password'] == F['confirmpassword']):
            return 'Sorry, passwords are not consistent. Registration failed. Please register again.'

        if not (len(F['empZipcode']) == 5):
            return 'Sorry, Zipcode is invalid. Registration failed. Please register again.'
        list_credit = []
        
        if not (15 <= len(F['creditcardnum1']) <= 16):
            return 'Sorry, creditcard1 is not a valid card. Registration failed. Please register again.'
        list_credit.append(F['creditcardnum1'])
        if F['creditcardnum2']:
            if not (15 <= len(F['creditcardnum2']) <= 16):
                return 'Sorry, creditcard2 is not a valid card. Registration failed. Please register again.'
            list_credit.append(F['creditcardnum2'])
        if F['creditcardnum3']:
            if not (15 <= len(F['creditcardnum3']) <= 16):
                return 'Sorry, creditcard3 is not a valid card. Registration failed. Please register again.'
            list_credit.append(F['creditcardnum3'])
        if F['creditcardnum4']:
            if not (15 <= len(F['creditcardnum4']) <= 16):
                return 'Sorry, creditcard4 is not a valid card. Registration failed. Please register again.'
            list_credit.append(F['creditcardnum4'])
        if F['creditcardnum5']:
            if not (15 <= len(F['creditcardnum5']) <= 16):
                return 'Sorry, creditcard5 is not a valid card. Registration failed. Please register again.'
            list_credit.append(F['creditcardnum5'])
        

        N = len(list_credit)
        # if not(0 < len(F['username']) <= 45 and 0 < len(F['password']) <= 200
        #     and 0 < len(F['firstname']) <= 45 and 0 < len(F['lastname']) <= 45
        #     and N >= 1 and N<= 5
        #     and 0 < len(F['comName']) <= 45) and 0 < len(F['empStreet']) <= 45
        #     and 0 < len(F['empCity']) <= 45) and  < len(F['empState']) <= 45
        #     and 0 < len(F['empZipcode']) <= 45)):
        #     print("Invalid username or password or firstname or lastname or creditcardnum")

        cursor = db.cursor()

        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))

            cursor.callproc('manager_customer_register', [F['username'], F['password'], 
            F['firstname'],F['lastname'],F['comName'],F['empStreet'],F['empCity'],F['empState'],
            F['empZipcode']])
            

            for i in range(N):
                cursor.callproc('MANAGER_customer_add_creditcard', [F['username'],list_credit[i]])
            render_template("manager_customer_registration.html",**extract(session,'COMPANY','MANAGER'))
            print("manager_customer_registration successfully!!!")
            return redirect("register_successfully.html")

        
        except pymysql.err.IntegrityError as e1:
            return "Manager-Customer register failed (username exists)"

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)

    COMPANY=getCOMPANY()
    session['COMPANY']=COMPANY
    MANAGER=getMANAGER_AVAILABLE()
    session['MANAGER']=MANAGER
    return render_template("manager_customer_registration.html",**extract(session,'COMPANY','MANAGER'))

    # return render_template("manager_customer_registration.html")


#screen 7
@app.route("/admin_only_functionality.html", methods=['GET','POST'])
def admin_only_functionality():
    if 'username' not in session:
        return redirect("login.html")
    return render_template("admin_only_functionality.html")

#screen 8
@app.route("/admin_customer_functionality.html", methods=['GET','POST'])
def admin_customer_functionality():
    if 'username' not in session:
        return redirect("login.html")
    return render_template("admin_customer_functionality.html")

#screen 9
@app.route("/manager_only_functionality.html", methods=['GET','POST'])
def manager_only_functionality():
    if 'username' not in session:
        return redirect("login.html")
    return render_template("manager_only_functionality.html")

#screen 10
@app.route("/manager_customer_functionality.html", methods=['GET','POST'])
def manager_customer_functionality():
    if 'username' not in session:
        return redirect("login.html")
    return render_template("manager_customer_functionality.html")

#screen 11
@app.route("/customer_functionality.html", methods=['GET','POST'])
def customer_functionality():
    if 'username' not in session:
        return redirect("login.html")
    return render_template("customer_functionality.html")

#screen 12
@app.route("/user_functionality.html", methods=['GET','POST'])
def user_functionality():
    if 'username' not in session:
        return redirect("login.html")
    return render_template("user_functionality.html")  

# Screen 13
@app.route("/admin_manage_user.html", methods=['GET','POST'])
def admin_manage_user():
    if 'username' not in session:
        return redirect("login.html")
    print(">>> Entering admin manager user page", session)
    if request.method == "POST":
        F = extract(request.form)

        cursor = db.cursor()
        print("F")
        print(F)

        args = [F['admin_manage_user_username'], F['status'],F['sortBy'], F['sortDirection'] ]

        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))

            callproc_with_result(cursor, "admin_filter_user", args, "adfilteruser")
            data = cursor.fetchall()
            print("fetchall:", data)

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)

        session['admin_manage_user_username'] = []
        session['creditCardCount'] = []
        session['userType'] = []
        session['status'] = []

        # print("len of data:", len(data))
        for i in range(len(data)):
            row = data[i]
            session['admin_manage_user_username'].append(row[0])
            session['creditCardCount'].append(row[1])
            session['userType'].append(row[2])
            session['status'].append(row[3])

        print("session:", session)
        print("hahahahhah")
        print( session['admin_manage_user_username'])
        return redirect("admin_manage_user_results.html")
        return render_template("admin_manage_user.html", **extract(session, 'admin_manage_user_username', 'creditCardCount', 'userType', 'status'))

    # else:
    #     F = extract(request.form)

    #     cursor = db.cursor()

        # try:
        # Execute the stored procedure:
        # def callproc_with_result(cursor, proc, args, result):
        #  cursor.callproc(proc, args)
        #  return cursor.execute('SELECT * FROM `{}`'.format(result))
            # if F['action'] == 'approve':
            #     cursor.callproc('admin_approve_user', [F['username']])
            # if F['action'] == 'decline':
            #     cursor.callproc('admin_decline_user', [F['username']])
        

    # except pymysql.err.IntegrityError as e1:
    #     return "user register failed(username exists)"

        # except pymysql.err.ProgrammingError as e:
        #     print("Error: unable to insert user registration data", e)

    return render_template("admin_manage_user.html")


# Screen 14
@app.route("/admin_manage_company.html", methods=['GET','POST'])
def admin_manage_company():
    if 'username' not in session:
        return redirect("login.html")
    print(">>> Entering manager company page", session)
    if request.method == "POST":
        F = extract(request.form)

        # if not (0 < len(F['username']) <= 45 and 0 < len(F['password']) <= 200
        #         and 0 < len(F['firstname']) <= 45 and 0 < len(F['lastname']) <= 45
        #         and N >= 1 and N <= 5):
        #     print("Invalid username or password or firstname or lastname or creditcardnum")

        cursor = db.cursor()
        
        if F['minCity']=='':
            F['minCity']=0
        if F['maxCity']=='':
            F['maxCity']=100
        if F['minTheater']=='':
            F['minTheater']=0
        if F['maxTheater']=='':
            F['maxTheater']=100
        if F['minEmployee']=='':
            F['minEmployee']=0
        if F['maxEmployee']=='':
            F['maxEmployee']=100
        
        args = [F['comName'], F['minCity'], F['maxCity'], F['minTheater'],
                F['maxTheater'], F['minEmployee'], F['maxEmployee'], F['sortBy'], F['sortDirection']]


        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))

            callproc_with_result(cursor, "admin_filter_company", args, "adfiltercom")
            data = cursor.fetchall()
            print("fetchall：", data)
            
            session['Name_screen14'] = []
            session['CityCovered_screen14'] = []
            session['Theaters_screen14'] = []
            session['Employee_screen14'] = []

            # print("len of data:", len(data))
            for i in range(len(data)):
                row = data[i]
                session['Name_screen14'].append(row[0])
                session['CityCovered_screen14'].append(row[1])
                session['Theaters_screen14'].append(row[2])
                session['Employee_screen14'].append(row[3])
                
            print("session:", session)
            return redirect("admin_manage_company_results.html")
            
        except pymysql.err.IntegrityError as e1:
            return "user register failed(username exists)"

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)
    
    COMPANY=getCOMPANY()
    session['COMPANY']=COMPANY
    session['numCityCover'] = []
    session['numTheater'] = []
    session['numEmployee'] = []

    # print("!!!")
    # print(data)
    # for i in range(len(data)):
        # row = data[i]
        # session['comName'].append(row[0])
        # session['numCityCover'].append(row[1])
        # session['numTheater'].append(row[2])
        # session['numEmployee'].append(row[3])

    print("session:", session)
    return render_template("admin_manage_company.html", **extract(session,'COMPANY'))
    
#screen admin_manage_company_results
@app.route("/admin_manage_company_results.html", methods=['GET','POST'])
def admin_manage_company_results():
    if 'username' not in session:
        return redirect("login.html")
    admin_manage_company_results = []
    admin_manage_company_results.append(session['Name_screen14'])
    admin_manage_company_results.append(session['CityCovered_screen14'])
    admin_manage_company_results.append(session['Theaters_screen14'])
    admin_manage_company_results.append(session['Employee_screen14'])
    return render_template("admin_manage_company_results.html", admin_manage_company_results = admin_manage_company_results)


# Screen 15
@app.route("/admin_create_theater.html", methods=['GET','POST'])
def admin_create_theater():
    if 'username' not in session:
        return redirect("login.html")
    print(">>> Entering create_theater page", session)
    if request.method == "POST":
        F = extract(request.form)
        cursor = db.cursor()

        args = [F['thName'], F['comName'], F['thStreet'], F['thCity'],
                F['thState'], F['thZipcode'], F['capacity'], F['managerUsername']]
                
        # print("args:", args)
        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)x
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))
            # print("args2:", args)

            cursor.callproc('admin_create_theater', args)
            return redirect("excuete_successfully.html")
        except pymysql.err.IntegrityError as e1:
            print("user register failed(username exists)")

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)

    # print("args3:", args)
    COMPANY=getCOMPANY()
    session['COMPANY']=COMPANY
    MANAGER=getMANAGER_AVAILABLE()
    session['MANAGER']=MANAGER
    return render_template("admin_create_theater.html",**extract(session,'COMPANY','MANAGER'))

#screem 16_pre
@app.route("/admin_view_companydetail_pre.html", methods=['GET','POST'])
def admin_view_companydetail_pre():
    if 'username' not in session:
        return redirect("login.html")
    #print(">>> Entering admin view company detail page", session)
    if request.method == "POST":
        F = extract(request.form)
        cursor = db.cursor()

        args = [F['comName']]
        session['company_choosen']=F['comName']        
        # print("args:", args)
        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)x
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))
            # print("args2:", args)

            cursor.callproc('admin_view_comDetail_emp', args)
            callproc_with_result(cursor, "admin_view_comDetail_emp", args, "adcomdetailemp")
            data = cursor.fetchall() 
            
            session['empFirstName']=[]
            session['empLastName']=[]
            for i in range(len(data)):
                row = data[i]
                session['empFirstName'].append(row[0])
                session['empLastName'].append(row[1])
           

            cursor.callproc('admin_view_comDetail_th', args)
            callproc_with_result(cursor, "admin_view_comDetail_th", args, "adcomdetailth")
            data = cursor.fetchall()            
            
            session['thName'] = []
            session['thManagerUsername'] = []
            session['thCity'] = []
            session['thState'] = []
            session['thCapacity'] = []

            # print("len of data:", len(data))
            for i in range(len(data)):
                row = data[i]
                session['thName'].append(row[0])
                session['thManagerUsername'].append(row[1])
                session['thCity'].append(row[2])
                session['thState'].append(row[3])
                session['thCapacity'].append(row[3])
            return redirect("admin_view_companydetail.html")
        except pymysql.err.IntegrityError as e1:
            print("user register failed(username exists)")

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)
    COMPANY=getCOMPANY()
    session['COMPANY']=COMPANY
    return render_template("admin_view_companydetail_pre.html",**extract(session,'COMPANY'))

# screen 16
@app.route("/admin_view_companydetail.html", methods=['GET','POST'])
def admin_view_companydetail():
    if 'username' not in session:
        return redirect("login.html")
    choose_company=session['company_choosen']
    admin_view_companydetail_1=[]
    admin_view_companydetail_1.append(session['empFirstName'])
    admin_view_companydetail_1.append(session['empLastName'])
    
    admin_view_companydetail = []
    admin_view_companydetail.append(session['thName'])
    admin_view_companydetail.append(session['thManagerUsername'])
    admin_view_companydetail.append(session['thCity'])
    admin_view_companydetail.append(session['thState'])
    admin_view_companydetail.append(session['thCapacity'])
    return render_template("admin_view_companydetail.html", choose_company=choose_company, admin_view_companydetail = admin_view_companydetail, admin_view_companydetail_1 = admin_view_companydetail_1)


# Screen 17
@app.route("/admin_create_movie.html", methods=['GET','POST'])
def admin_create_movie():
    if 'username' not in session:
        return redirect("login.html")
    print(">>> Entering admin_create_movie.html page", session)
    if request.method == "POST":
        F = extract(request.form)
        cursor = db.cursor()

        args = [F['movName'], F['movDuration'], F['movReleaseDate']]
        # print("args:", args)
        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)x
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))
            # print("args2:", args)

            cursor.callproc('admin_create_mov', args)
            return redirect("excuete_successfully.html")

        except pymysql.err.IntegrityError as e1:
            print("user register failed(username exists)")

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)

    # print("args3:", args)
    return render_template("admin_create_movie.html")





# screen 18
@app.route("/manager_theater_overview.html", methods=['POST','GET'])
def manager_theater_overview():
    if 'username' not in session:
        return redirect("login.html")
    print(">>> Entering manager theater overview page", session)
    if request.method == "POST":
        F = extract(request.form)
        print('F')
        print(F)
        print(len(F))

        # if not (0 < len(F['username']) <= 45 and 0 < len(F['password']) <= 200
        #         and 0 < len(F['firstname']) <= 45 and 0 < len(F['lastname']) <= 45
        #         and N >= 1 and N <= 5):
        #     print("Invalid username or password or firstname or lastname or creditcardnum")
        if F['minMovDuration'] == '':
           F['minMovDuration'] = 0
        if F['maxMovDuration'] == '':
            F['maxMovDuration'] = 1000000
        if F['minMovReleaseDate'] == '':
            F['minMovReleaseDate'] = '1000-01-01'
        if F['maxMovReleaseDate'] == '':
            F['maxMovReleaseDate'] = '3000-12-12'
        if F['minMovPlayDate'] == '':
            F['minMovPlayDate'] = '1000-01-01'
        if F['maxMovPlayDate'] == '':
            F['maxMovPlayDate'] = '3000-12-12'

        cursor = db.cursor()
        # print('includeNotPlayed: ')
        # print(F['includeNotPlayed'])
        if 'includeNotPlayed' in F:
            args = [session['username'], F['movName'], F['minMovDuration'], F['maxMovDuration'],
                F['minMovReleaseDate'], F['maxMovReleaseDate'], F['minMovPlayDate'], F['maxMovPlayDate'], 1]
        else:
            args = [session['username'], F['movName'], F['minMovDuration'], F['maxMovDuration'],
                F['minMovReleaseDate'], F['maxMovReleaseDate'], F['minMovPlayDate'], F['maxMovPlayDate'], 0]

        # args = [F['manUsername'], F['movName'], F['minMovDuration'], F['maxMovDuration'],
        #         F['minMovReleaseDate'], F['maxMovReleaseDate'], F['minMovPlayDate'], F['maxMovPlayDate'], F['includeNotPlayed']]
        # args = [session['username'], F['movName'], F['minMovDuration'], F['maxMovDuration'],
        #         F['minMovReleaseDate'], F['maxMovReleaseDate'], F['minMovPlayDate'], F['maxMovPlayDate'], F['includeNotPlayed']]


        
        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))

            callproc_with_result(cursor, "manager_filter_th", args, "manfilterth")
            data = cursor.fetchall()

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)

        session['movName'] = []
        session['movDuration'] = []
        session['movReleaseDate'] = []
        session['movPlayDate'] = []

        # print("len of data:", len(data))
        for i in range(len(data)):
            row = data[i]
            session['movName'].append(row[0])
            session['movDuration'].append(row[1])
            session['movReleaseDate'].append(row[2])
            session['movPlayDate'].append(row[3])

        print("session:", session)
        return redirect("manager_theater_overview_results.html")
    return render_template("manager_theater_overview.html", **extract(session, 'movName', 'movDuration', 'movReleaseDate', 'movPlayDate'))
    # return render_template("manager_theater_overview.html")

# Screen 19
@app.route("/manager_schedule_movie.html", methods=['GET','POST'])
def manager_schedule_movie():
    if 'username' not in session:
        return redirect("login.html")
    print(">>> Entering manager_schedule_mov page", session)
    if request.method == "POST":
        F = extract(request.form)

        # if not (0 < len(F['username']) <= 45 and 0 < len(F['password']) <= 200
        #         and 0 < len(F['firstname']) <= 45 and 0 < len(F['lastname']) <= 45
        #         and N >= 1 and N <= 5):
        #     print("Invalid username or password or firstname or lastname or creditcardnum")

        cursor = db.cursor()
        # print("session:", session['username'])
        if F['movReleaseDate'] > F['movPlayDate']:
            return 'The movie releasedate should be before the movie playdate!!!'
        args = [session['username'], F['movName'], F['movReleaseDate'], F['movPlayDate']]
        cursor.execute("select releaseDate from movie where moviename='{}'".format(F['movName']))
        data = cursor.fetchone()
        #print('hahdjkdjtd',data == '2019-08-12')
        print("strstrstr",str(data))
        if F['movReleaseDate'] == str(data):

            print("Wrong movie releasedate input!!!")
            return "Wrong movie releasedate input!!!"

        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))

            cursor.callproc("manager_schedule_mov", args)
            # data = cursor.fetchall()
            # print("fetchall：", data)
        except pymysql.err.IntegrityError as e1:

            return "Wrong Movie releasedate input!!!"

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)
        return redirect("excuete_successfully.html")
        #return render_template("manager_schedule_movie.html")
    else:
        MOVIE = getMOVIE()
        session['MOVIE'] = MOVIE
        return render_template("manager_schedule_movie.html", **extract(session, 'MOVIE'))

        



# Screen 20
@app.route("/customer_explore_movie.html", methods=['GET', 'POST'])
def customer_explore_movie():
    if 'username' not in session:
        return redirect("login.html")
    print(">>> Entering admin customer_view_and_filter_mov page", session)
    if request.method == "POST":
        F = extract(request.form)

        # if not (0 < len(F['username']) <= 45 and 0 < len(F['password']) <= 200
        #         and 0 < len(F['firstname']) <= 45 and 0 < len(F['lastname']) <= 45
        #         and N >= 1 and N <= 5):
        #     print("Invalid username or password or firstname or lastname or creditcardnum")

        cursor = db.cursor()

        # if 'movName' not in F:
        #     print("not in F")
        #     return render_template("customer_explore_movie.html")

        if not F['thCity'] :
            F['thCity'] = 'ALL'
        if not F['minMovPlayDate']:
            F['minMovPlayDate'] = '1000-01-01'
        if not F['maxMovPlayDate']:
            F['maxMovPlayDate'] = '3000-12-12'


        args = [F['movName'], F['comName'], F['thCity'], F['thState'], F['minMovPlayDate'], F['maxMovPlayDate']]

        print("FFFFF:", F)
        
        
    
        print("args" , args)

        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))

            callproc_with_result(cursor, "customer_filter_mov", args, "CosFilterMovie")
            data = cursor.fetchall()
            print("fetchall：", data)

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)
        session_for_screen_20 = {}
        session_for_screen_20['movName'] = []
        session_for_screen_20['thName'] = []
        session_for_screen_20['thStreet'] = []
        session_for_screen_20['thCity'] = []
        session_for_screen_20['thState'] = []
        session_for_screen_20['thZipcode'] = []
        session_for_screen_20['comName'] = []
        session_for_screen_20['movPlayDate'] = []
        session_for_screen_20['movReleaseDate'] = []


        # print("len of data:", len(data))
        for i in range(len(data)):
            row = data[i]

            session_for_screen_20['movName'].append(row[0])
            session_for_screen_20['thName'].append(row[1])
            session_for_screen_20['thStreet'].append(row[2])
            session_for_screen_20['thCity'].append(row[3])
            session_for_screen_20['thState'].append(row[4])
            session_for_screen_20['thZipcode'].append(row[5])
            session_for_screen_20['comName'].append(row[6])
            session_for_screen_20['movPlayDate'].append(row[7])
            session_for_screen_20['movReleaseDate'].append(row[8])
        session["session_for_screen_20"] = session_for_screen_20
        print("session_for_screen_20")
        print(session_for_screen_20)
        print("session:", session)
        # return render_template("customer_explore_movie.html",
        #                        **extract(session, 'movName', 'thName', 'thStreet', 'thCity',
        #                                  'thState', 'thZipcode', 'comName', 'movPlayDate', 'movReleaseDate'))
        return redirect("customer_explore_movie_results.html")


    else:
        MOVIE = getMOVIE()
        session['MOVIE'] = MOVIE
        COMPANY = getCOMPANY()
        session['COMPANY'] = COMPANY
        STATE = getSTATE()
        session['STATE'] = STATE
        print("session:", session)

        return render_template("customer_explore_movie.html",**extract(session,'MOVIE','COMPANY', 'STATE'))

#screen customer_explore_movie_results
@app.route("/customer_explore_movie_results.html", methods=['GET','POST'])
def customer_explore_movie_results():
    if 'username' not in session:
        return redirect("login.html")
    if request.method == "GET":
        customer_explore_movie_results = []
        customer_explore_movie_results.append(session['session_for_screen_20']['movName'])
        customer_explore_movie_results.append(session['session_for_screen_20']['thName'])
        session['session_for_screen_20']['Address'] = []
        session['session_for_screen_20']['movPlayDate_front'] = []
        session['session_for_screen_20']['movReleaseDate_front'] = []
        session['session_for_screen_20']["select_movie"] = []

        for i in range(len(session['session_for_screen_20']['thStreet'])):
            address = session['session_for_screen_20']['thStreet'][i] + ", " + session['session_for_screen_20']['thCity'][i] + \
                      ", " + session['session_for_screen_20']['thState'][i] + " " + session['session_for_screen_20']['thZipcode'][i]
            session['session_for_screen_20']['Address'].append(address)
            session['session_for_screen_20']['movPlayDate_front'].append(str(datetime.datetime.strptime(session['session_for_screen_20']['movPlayDate'][i][5:-13],
                                                                           '%d %b %Y').date()))
            session['session_for_screen_20']['movReleaseDate_front'].append(str(datetime.datetime.strptime(session['session_for_screen_20']['movReleaseDate'][i][5:-13],
                                                                           '%d %b %Y').date()))
            session['session_for_screen_20']["select_movie"].append(session['session_for_screen_20']['movName'][i] + "||" + session['session_for_screen_20']['thName'][i] + "||" +
                                           address + "||" + session['session_for_screen_20']['comName'][i] + "||" +
                                           session['session_for_screen_20']['movPlayDate_front'][i] + "||" + session['session_for_screen_20']['movReleaseDate_front'][i])

        customer_explore_movie_results.append(session['session_for_screen_20']['Address'])
        customer_explore_movie_results.append(session['session_for_screen_20']['comName'])
        customer_explore_movie_results.append(session['session_for_screen_20']['movPlayDate_front'])
        customer_explore_movie_results.append(session['session_for_screen_20']['movReleaseDate_front'])
        customer_explore_movie_results.append(session['session_for_screen_20']['select_movie'])
        return render_template("customer_explore_movie_results.html", customer_explore_movie_results = customer_explore_movie_results)

    else:
        F = extract(request.form)

        cursor = db.cursor()
        movName, thName, _, comName, movPlayDate_front, movReleaseDate_front=F['selected'].split("||")
        args = [F['creditCardNum'], movName, movReleaseDate_front, thName, comName, movPlayDate_front]
        try:
            # print("args:", args)
            cursor.callproc("customer_view_mov", args)
            # print("done")



        except pymysql.err.IntegrityError as e1:
            print("user register failed(username exists)")

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)

        return redirect("customer_view_history.html")

# Screen 21
@app.route("/customer_view_history.html", methods=['GET'])
def customer_view_history():
    if 'username' not in session:
        return redirect("login.html")
    print(">>> Entering customer_view_history page", session)
    if request.method == "GET":
        F = extract(request.form)

        # if not (0 < len(F['username']) <= 45 and 0 < len(F['password']) <= 200
        #         and 0 < len(F['firstname']) <= 45 and 0 < len(F['lastname']) <= 45
        #         and N >= 1 and N <= 5):
        #     print("Invalid username or password or firstname or lastname or creditcardnum")

        cursor = db.cursor()

        args = [session['username']]

        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))
            callproc_with_result(cursor, "customer_view_history", args, "CosViewHistory")

            data = cursor.fetchall()
            print("fetchall：", data)
        except pymysql.err.IntegrityError as e1:
            return "user register failed(username exists)"

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)

        session_for_screen_21 = {}

        session_for_screen_21['movName'] = []
        session_for_screen_21['thName'] = []
        session_for_screen_21['comName'] = []
        session_for_screen_21['creditCardNum'] = []
        session_for_screen_21['movPlayDate'] = []

        # session['session_for_screen_21'] = session_for_screen_21
        # print("len of data:", len(data))
        for i in range(len(data)):
            row = data[i]
            session_for_screen_21['movName'].append(row[0])
            session_for_screen_21['thName'].append(row[1])
            session_for_screen_21['comName'].append(row[2])
            session_for_screen_21['creditCardNum'].append(row[3])
            session_for_screen_21['movPlayDate'].append(row[4])
        to_view_history = []
        to_view_history.append(session_for_screen_21['movName'])
        to_view_history.append(session_for_screen_21['thName'])
        to_view_history.append(session_for_screen_21['comName'])
        to_view_history.append(session_for_screen_21['creditCardNum'])
        to_view_history.append(session_for_screen_21['movPlayDate'])

    print("session:", session)
    return render_template("customer_view_history.html",
                           to_view_history=to_view_history)



# screen 22
@app.route("/user_explore_theater.html", methods=['GET','POST'])
def user_explore_theater():
    if 'username' not in session:
        return redirect("login.html")
    #print(">>> Entering admin manager user page", session)
    if request.method == "POST":
        F = extract(request.form)

        cursor = db.cursor()
        if not F['thCity'] :
            F['thCity'] = 'ALL'

        args = [F['thName'], F['comName'], F['thCity'],F['thState']]

        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))

            callproc_with_result(cursor, "user_filter_th", args, "UserFilterTh")
            data = cursor.fetchall()
            print("fetchall：", data)

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)
        session_for_screen_22 = {}
        session_for_screen_22['thName'] = []
        session_for_screen_22['thStreet'] = []
        session_for_screen_22['thCity'] = []
        session_for_screen_22['thState'] = []
        session_for_screen_22['thZipcode'] = []
        session_for_screen_22['comName'] = []

        # print("len of data:", len(data))
        for i in range(len(data)):
            row = data[i]
            session_for_screen_22['thName'].append(row[0])
            session_for_screen_22['thStreet'].append(row[1])
            session_for_screen_22['thCity'].append(row[2])
            session_for_screen_22['thState'].append(row[3])
            session_for_screen_22['thZipcode'].append(row[4])
            session_for_screen_22['comName'].append(row[5])
        session["session_for_screen_22"] = session_for_screen_22
        # print("session:", session)
        return redirect("user_explore_theater_results.html")

    else:
        THEATER = getTHEATER()
        session['THEATER'] = THEATER
        COMPANY = getCOMPANY()
        session['COMPANY'] = COMPANY
        STATE = getSTATE()
        session['STATE'] = STATE
        print("session:", session)


        return render_template("user_explore_theater.html", **extract(session, 'THEATER', 'COMPANY', 'STATE'))


#screen user_explore_theater_results
@app.route("/user_explore_theater_results.html", methods=['GET','POST'])
def user_explore_theater_results():
    if 'username' not in session:
        return redirect("login.html")
    if request.method == "GET":
        user_explore_theater_results = []
        user_explore_theater_results.append(session['session_for_screen_22']['thName'])
        session['session_for_screen_22']['Address'] = []
        session['session_for_screen_22']['selected_theater'] = []

        for i in range(len(session['session_for_screen_22']['thStreet'])):
            address = session['session_for_screen_22']['thStreet'][i] + ", " + \
                      session['session_for_screen_22']['thCity'][i] + \
                      ", " + session['session_for_screen_22']['thState'][i] + " " +\
                      session['session_for_screen_22']['thZipcode'][i]
            session['session_for_screen_22']['Address'].append(address)
            # session['movPlayDate_front'].append(str(datetime.datetime.strptime(session['movPlayDate'][i][5:-13],
            #                                                                '%d %b %Y').date()))
            # session['movReleaseDate_front'].append(str(datetime.datetime.strptime(session['movReleaseDate'][i][5:-13],
            #                                                                '%d %b %Y').date()))
            session['session_for_screen_22']["selected_theater"].append(
                session['session_for_screen_22']['thName'][i] + "||" + address + "||" +
                session['session_for_screen_22']['comName'][i])
        user_explore_theater_results.append(session['session_for_screen_22']['Address'])
        user_explore_theater_results.append(session['session_for_screen_22']['comName'])
        user_explore_theater_results.append(session['session_for_screen_22']['selected_theater'])


        # print("session_for_screen_22:", session['session_for_screen_22'])
        # print("user_explore_theater_results:", user_explore_theater_results)
        return render_template("user_explore_theater_results.html", user_explore_theater_results = user_explore_theater_results)
    else:
        F = extract(request.form)

        cursor = db.cursor()

        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))
            thName, _, comName = F['selected'].split("||")

            cursor.callproc('user_visit_th', [thName, comName, F['visitDate'], session['username']])


        # except pymysql.err.IntegrityError as e1:
        #     return "user register failed(username exists)"

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)

        return redirect("excuete_successfully.html")


# screen 23
@app.route("/user_visit_history.html", methods=['GET','POST'])
def user_visit_history():
    if 'username' not in session:
        return redirect("login.html")
    # print(">>> Entering manager theater overview page", session)
    if request.method == "POST":
        F = extract(request.form)

        # if not (0 < len(F['username']) <= 45 and 0 < len(F['password']) <= 200
        #         and 0 < len(F['firstname']) <= 45 and 0 < len(F['lastname']) <= 45
        #         and N >= 1 and N <= 5):
        #     print("Invalid username or password or firstname or lastname or creditcardnum")

        cursor = db.cursor()
        print(session['username'])
        F['username']=session['username']

        
        if F['minVisitDate'] == '':
            F['minVisitDate'] = '1000-01-01'
        if F['maxVisitDate'] == '':
            F['maxVisitDate'] = '3000-12-12'
        args = [F['username'], F['minVisitDate'], F['maxVisitDate']]


        try:
            # Execute the stored procedure:
            # def callproc_with_result(cursor, proc, args, result):
            #  cursor.callproc(proc, args)
            #  return cursor.execute('SELECT * FROM `{}`'.format(result))

            callproc_with_result(cursor, "user_filter_visitHistory", args, "UserVisitHistory")
            data = cursor.fetchall()
            print("this is data")
            print(data)

        except pymysql.err.ProgrammingError as e:
            print("Error: unable to insert user registration data", e)

        session['thName'] = []
        session['thStreet'] = []
        session['thCity'] = []
        session['thState'] = []
        session['thZipcode'] = []
        session['comName'] = []
        session['visitDate'] = []

        # print("len of data:", len(data))
        for i in range(len(data)):
            row = data[i]
            session['thName'].append(row[0])
            session['thStreet'].append(row[1])
            session['thCity'].append(row[2])
            session['thState'].append(row[3])
            session['thZipcode'].append(row[4])
            session['comName'].append(row[5])
            session['visitDate'].append(row[6])
        return redirect("user_visit_history_results.html")

    #print("session:", session)
    COMPANY=getCOMPANY()
    session['COMPANY']=COMPANY
    return render_template("user_visit_history.html", **extract(session, 'COMPANY','username'))
    
#screen user_visit_history_results
@app.route("/user_visit_history_results.html", methods=['GET','POST'])
def user_visit_history_results():
    if 'username' not in session:
        return redirect("login.html")
    user_visit_history_results = []
    user_visit_history_results.append(session['thName'])
    user_visit_history_results.append(session['thStreet'])
    user_visit_history_results.append(session['thCity'])
    user_visit_history_results.append(session['thState'])
    user_visit_history_results.append(session['thZipcode'])
    user_visit_history_results.append(session['comName'])
    user_visit_history_results.append(session['visitDate'])
    return render_template("user_visit_history_results.html", user_visit_history_results = user_visit_history_results)



if __name__ == "__main__":
    app.run(debug=True, port=5001)


