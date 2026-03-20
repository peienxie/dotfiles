FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    openssh-client \
    sudo \
    && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /usr/local/nvm
ENV NVM_VERSION v0.40.4
ENV NODE_VERSION 20
RUN mkdir $NVM_DIR \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && npm i -g bun

RUN useradd -m -s /bin/bash opencode \
    && echo "opencode ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/opencode \
    && chmod 0440 /etc/sudoers.d/opencode
USER opencode
WORKDIR /home/opencode

RUN curl -fsSL https://opencode.ai/install | bash 
RUN . $NVM_DIR/nvm.sh \
    && bunx oh-my-opencode install --no-tui \
        --claude=no \
        --gemini=no \
        --copilot=no \
        --openai=no \
        --opencode-go=no \
        --opencode-zen=no \
        --zai-coding-plan=no

ENV PATH="/home/opencode/.opencode/bin:${PATH}"

ENTRYPOINT ["opencode"]
