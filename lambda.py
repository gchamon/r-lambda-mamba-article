import subprocess


def handler(event, context):
    subprocess.run(["bash", "-c", (
        "./hello-world.R"
        f" --names-to-greet {' '.join(event['names_to_greet'])}"
    )], check=True)
