#!/bin/bash

# 환경 변수 설정
export WORK="/root/despeed-base"
export NVM_DIR="$HOME/.nvm"

# 색상 정의
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # 색상 초기화

echo -e "${GREEN}despeed 봇을 설치합니다.${NC}"
echo -e "${GREEN}스크립트작성자: https://t.me/kjkresearch${NC}"
echo -e "${GREEN}출처: https://github.com/airdropinsiders/DeSpeed-Auto-Bot${NC}"

echo -e "${GREEN}설치 옵션을 선택하세요:${NC}"
echo -e "${YELLOW}1. despeed 봇 새로 설치${NC}"
echo -e "${YELLOW}2. 재실행하기${NC}"
read -p "선택: " choice

case $choice in
  1)
    echo -e "${GREEN}despeed 봇을 새로 설치합니다.${NC}"

    # 사전 필수 패키지 설치
    echo -e "${YELLOW}시스템 업데이트 및 필수 패키지 설치 중...${NC}"
    sudo apt update
    sudo apt install -y git

    echo -e "${YELLOW}작업 공간 준비 중...${NC}"
    if [ -d "$WORK" ]; then
        echo -e "${YELLOW}기존 작업 공간 삭제 중...${NC}"
        rm -rf "$WORK"
    fi

    # GitHub에서 코드 복사
    echo -e "${YELLOW}GitHub에서 코드 복사 중...${NC}"
    git clone https://github.com/KangJKJK/despeed-base
    cd "$WORK"

    # Node.js LTS 버전 설치 및 사용
    echo -e "${YELLOW}Node.js 설치 상태 확인 중...${NC}"
    if ! command -v node &> /dev/null; then
        echo -e "${YELLOW}Node.js LTS 버전을 설치하고 설정 중...${NC}"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # nvm을 로드합니다
        nvm install --lts
        nvm use --lts
    else
        echo -e "${GREEN}Node.js가 이미 설치되어 있습니다.${NC}"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # nvm을 로드합니다
        nvm use --lts
    fi
    npm install

    echo -e "${GREEN}봇을 실행하기전에 다음 단계들을 먼저 진행해주세요.${NC}"
    echo -e "${YELLOW}1.공식사이트 가입 및 연동${NC}"
    echo -e "${YELLOW}https://app.despeed.net/register?ref=YzeBAMiWdFkO${NC}"
    echo -e "${YELLOW}2.크롬확장프로그램 설치 및 로그인${NC}"
    echo -e "${YELLOW}https://chromewebstore.google.com/detail/despeed-validator/ofpfdpleloialedjbfpocglfggbdpiem${NC}"

    read -p "위 작업이 끝나면 엔터를 눌러 다음단계로 진행하세요 : "

    # 프록시파일 생성
    echo -e "${YELLOW}1.프록시 정보를 입력하세요. 입력형식: http://user:pass@ip:port${NC}"
    echo -e "${YELLOW}2.여러 개의 프록시는 줄바꿈으로 구분하세요.${NC}"
    echo -e "${YELLOW}3.입력을 마치려면 엔터를 두 번 누르세요.${NC}"

    {
        while IFS= read -r line; do
            [[ -z "$line" ]] && break
            echo "$line"
        done
    } > "$WORK/proxy.txt"

    # 계정토큰파일 생성
    echo -e "${GREEN}계정토큰을 얻어야합니다. 토큰이 만료될 가능성도 있으니 가끔씩 점검해주세요.{NC}"
    echo -e "${YELLOW}1.대시보드 사이트에서 F12를 눌러주세요${NC}"
    echo -e "${YELLOW}2.여러 개의 프록시는 줄바꿈으로 구분하세요.${NC}"
    echo -e "${YELLOW}3.입력을 마치려면 엔터를 두 번 누르세요.${NC}"

    {
        while IFS= read -r line; do
            [[ -z "$line" ]] && break
            echo "$line"
        done
    } > "$WORK/token.txt"

        # 봇 구동
        npm run start
        ;;
        
    2)
        echo -e "${GREEN}despeed봇을 재실행합니다.${NC}"
        
        # nvm을 로드합니다
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # nvm을 로드합니다
        cd "$WORK"

        # 봇 구동
        npm run start
        ;;

    *)
        echo -e "${RED}잘못된 선택입니다. 다시 시도하세요.${NC}"
        ;;
    esac
