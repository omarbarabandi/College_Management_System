from __init__ import app, db
from flask import Flask, render_template, flash, request, redirect, url_for, jsonify, session

@app.route('/create_user', methods=['POST'])
def create_user():
    universityid = request.form['universityid']
    firstname = request.form["firstname"]
    lastname = request.form["lastname"]
    password = request.form['password']
   
    # Check if the user already exists in the database
    cursor = mydb.cursor()
    cursor.execute("SELECT * FROM users WHERE universityid=%s", (universityid,))
    existing_user = cursor.fetchone()
    if existing_user:
        flash("That universityid is already in use! Please log in")
        print("redirected with duplicate universityid")
        db.connection.commit()
        return redirect('/')
    else:
        while True:
            schoolid = random.randint(10000000,99999999)
            cursor.execute("SELECT * FROM users WHERE schoolid=%s", (schoolid,))
            existing_schoolid = cursor.fetchone()
            if not existing_schoolid:
                break
        cursor.execute('INSERT INTO user (universityid, password, firstname, lastname, schoolid) VALUES (%s, %s, %s, %s)', (schoolid, password, firstname, lastname))	
        db.connection.commit()
        return redirect('/')	
        
    return render_template('login.html')
=======


@app.route('/', methods=['GET', 'POST'])
def login():
	if request.method == 'POST':
		username = request.form["username"]
		password = request.form["password"]
		cursor = db.connection.cursor()
		(cursor.execute('SELECT * FROM user WHERE username = %s AND password = %s', (username, password)))
		userData = cursor.fetchone()
		#print(userData)
		
		if(userData is None):
			db.connection.commit()
			return render_template("home.html", message = "Incorrect Username or Password")
		
		else:
			id = userData['universityid']
			cursor.execute("SELECT 'sysAdmin' AS role FROM sysAdmin WHERE user = %s UNION SELECT 'gradSecretary' AS role FROM gradSecretary WHERE user = %s UNION SELECT 'facultyInstructors' AS role FROM facultyInstructors WHERE user = %s UNION SELECT 'student' AS role FROM student WHERE user = %s UNION SELECT 'applicant' AS role FROM applications WHERE UID = %s UNION SELECT 'alumni' AS role FROM alumni WHERE UID = %s UNION SELECT 'facultyReviewer' AS role FROM Reviewers WHERE ID = %s UNION SELECT 'chairOfCommittee' AS role FROM Committee WHERE ID = %s", (id, id, id, id, id, id, id, id))
			userRole = cursor.fetchone()
			# cursor.execute("")
			#print(userInfo)
			#session['email'] = userData[0]
			# print(userData['universityid'])
			# print('Pass new login')
			session['fname'] = userData['firstname']
			session['lname'] = userData['lastname']
			session['role'] = userRole['role']
			session['id'] = userData['universityid']
			db.connection.commit()
			if session['role'] == 'student':
				return redirect('/regdashboard')

			if session['role'] == 'facultyInstructors':
				return redirect('/staffDashboard')
			
			if session['role'] == 'gradSecretary':
				return redirect(url_for('gsDashboard'))

			if session['role'] == 'sysAdmin':
				return redirect('/sysAdminDashboard')

            if session['role'] == 'applicant':
                return #applicant dash

            if session['role'] == 'alumni':
                return #alumni dash

            if session['role'] == 'factultyReviewer':
                return #FR dash

            if session['role'] == 'chairOfCommittee':
                return #COC dash

	return render_template('home.html') #changed this from index to home
## Register for account
>>>>>>> origin/main



@app.route("/application_form", methods=["GET", "POST"])
def application_form():
    try:
        if request.method == "POST":
            if 'id' in session:
                cur = mydb.cursor()
                try:
                    # check if the applicant has applied before
                    cur.execute(
                        "SELECT COUNT(*) FROM applications WHERE UID=%s", (session['id'],))
                    result = cur.fetchone()
                    if result[0] > 0:
                        # the applicant has applied before
                        cur.close()
                        return "Maximum of one application per person"

                    uid = session['id']
					first_name = request.form.get("FirstName")
					last_name = request.form.get("LastName")
					email = request.form.get("Email")
					address = request.form.get("Address")
					ssn = request.form.get("SSN")
					degree_sought = request.form.get("DegreeSought")
					admission_date = request.form.get("AdmissionDate")
					# prior_degrees = request.form.get("PriorDegrees")
					experience = request.form.get("Experience")
					WriterName = request.form.get("LetterWriterName")
					WriterEmail = request.form.get("LetterWriterEmail")
					verbal_score = request.form.get("VerbalScore")
					quantitative_score = request.form.get("QuantitativeScore")
					total_score = request.form.get("TotalScore")
					status = "Pending"

                    # insert the application information into the database
                    cur.execute("INSERT INTO applications (UID, FirstName, LastName, Email, Address, SSN, DegreeSought, AdmissionDate, Status) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)", (
                        uid, first_name, last_name, email, address, ssn, degree_sought, admission_date, status))
                    mydb.commit()

		    cur.execute("INSERT INTO GRE_Scores (UID, VerbalScore, QuantitativeScore, TotalScore) VALUES (%s, %s, %s, %s)",
					            (uid, verbal_score, quantitative_score, total_score))
            	    mydb.commit()
                    
		    cur.execute("INSERT INTO Work_Experience (UID, Experience) VALUES (%s, %s)", (uid, experience))
                    mydb.commit()
                    
		    cur.execute("INSERT INTO RecommendationLetters (UID, LetterWriterName, LetterWriterEmail ) VALUES (%s, %s, %s)", (uid, WriterName, WriterEmail))
		    mydb.commit()
                    cur.close()

                    session['decision'] = 'complete'

					# return to dashboard
                    return redirect(url_for("/"))
                except Exception as e:
                    # close the cursor and display an error message
                    cur.close()
                    return f"An error occurred while processing your application: {str(e)}"
            else:
                return redirect(url_for("login"))
        else:
            return render_template("application_form.html")
    except Exception as e:
        return f"An unexpected error occurred: {str(e)}"
