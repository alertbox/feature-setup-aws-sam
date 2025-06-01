<p align="center">
  <a href="https://aws.amazon.com/serverless/sam/"><img src="https://raw.githubusercontent.com/github/explore/fbceb94436312b6dacde68d122a5b9c7d11f9524/topics/aws/aws.png" alt="Logo" height=170></a>
</p>
<h1 align="center">Setup AWS SAM in Dev Containers</h1>

Download, install, and setup specific version of [AWS SAM](https://aws.amazon.com/serverless/sam/) in your Dev Container.


## Quick Start

[![Open a Dev Container](https://img.shields.io/static/v1?style=for-the-badge&label=Dev+Container&message=Open&color=blue&logo=visualstudiocode)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/alertbox/try-dotnet-on-aws)

You can also add this feature to your `devcontainer.json` file.

```json filename="devcontainer.json"
"features": {
    "ghcr.io/alertbox/aws/sam:1": {}
}
```
## Options

See [src/sam](./src/sam/README.md) folder to learn more about options.


## Contributing

The official repo to contribute would be [@aws/aws-sam-cli](https://github.com/aws/aws-sam-cli?tab=readme-ov-file#readme).

Have a suggestion or a bug fix? Just open a pull request or an issue. Include clear and simple instructions possible.

## License

Copyright (c) The Alertbox, Inc. (@alertbox). All rights reserved.

The source code is license under the [MIT license](#MIT-1-ov-file).
