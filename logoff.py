import subprocess
from guizero import App, Text, PushButton

app = App(title="Logoff", width=240, height=50, layout="grid")

def shutdown():
    bashCommand = "sudo shutdown -r now"
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    
def reboot():
    bashCommand2 = "sudo reboot"
    process = subprocess.Popen(bashCommand2.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    
def logout():
    print("test")

option1 = PushButton(app, command=shutdown, text="Shutdown", grid=[3,1])
option1 = PushButton(app, command=reboot, text="Reboot", grid=[2,1])
option1 = PushButton(app, command=logout, text="Logout", grid=[1,1])

app.display()