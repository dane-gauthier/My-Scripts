import time
import os

def update():
	os.system('sudo apt-get update')
	print "Update Complete"
	raw_input("")
	menu()

def upgrade():
	os.system('sudo apt-get upgrade')
	print "Done"
	raw_input("")
	menu()

def install():
	package = raw_input("What do you want to install? ")
	os.system('sudo apt-get install '+package+' ')
	print "Installation Complete"
	raw_input("")
	menu()

def cleanremove():
	os.system("sudo apt-get autoremove")
	os.system("sudo apt-get autoclean")
	print "Cleaning Complete"
	raw_input("")
	menu()

def backup():
	os.system("sudo /home/pi/./backup.sh")
	print "Backup Complete"
	raw_input("")
	menu()

def release_upgrade():
	os.system("sudo do-release-upgrade")
	print "Release Upgrade Complete"
	print "Would you like to continue?"
	answer = raw_input("> ")
	if answer == "yes" or "Yes":
		menu()
	elif answer == "no" or "No":
		exit()

def uninstall():
	package = raw_input("Type name of package to remove: ")
	os.system('sudo apt-get remove '+package+' ')
	print "Removal Complete"
	raw_input("")
	menu()


def menu():
	os.system("clear")
	print "Ubuntu Updating script"
	print "ver. 1"

	print """
What would you like to do?
1. Update
2. Upgrade
3. Do a Release Upgrade
4. Install
5. Clean and remove old packages
6. Backup Home Directory
7. Remove an installed package
0. Exit"""

	option = raw_input("> ")

	if option == "1":
		update()
	elif option == "2":
		upgrade()
	elif option == "3":
		release_upgrade()
	elif option == "4":
		install()
	elif option == "5":
		cleanremove()
	elif option == "6":
		backup()
	elif option == "7":
		uninstall()		
	elif option == "0":
		exit()
	else:
		print "Sorry, that is an invalid option."

menu()

