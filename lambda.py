import subprocess


def handler(event, context):
    subprocess.run(["bash", "-c", "./hello-world.R"], check=True)
