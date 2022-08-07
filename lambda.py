import subprocess
import os


def handler(event, context):
    subprocess.run(
        ["bash", "-c",
         (f"source {os.path.join(os.environ['MICROMAMBA_INSTALL_FOLDER'], '.bashrc')} && "
          "./hello-world.R"
          f" --names-to-greet {' '.join(event['names_to_greet'])}")],
        check=True
    )
