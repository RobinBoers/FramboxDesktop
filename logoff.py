import subprocess
from guizero import App, Text, PushButton

app = App(title="Session", width=240, height=50, layout="grid")

def shutdown():
    bashCommand = "sudo shutdown now"
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    
def reboot():
    bashCommand2 = "sudo reboot"
    process2 = subprocess.Popen(bashCommand2.split(), stdout=subprocess.PIPE)
    output, error = process2.communicate()
    
def logout():
    bashCommand3 = "openbox --exit"
    process3 = subprocess.Popen(bashCommand3.split(), stdout=subprocess.PIPE)
    output, error = process3.communicate()

option1 = PushButton(app, command=shutdown, text="Shutdown", grid=[3,1])
option2 = PushButton(app, command=reboot, text="Reboot", grid=[2,1])
option3 = PushButton(app, command=logout, text="Logout", grid=[1,1])

app.display()