et -e

# ==========================================
# TeX Live 자동 설치 스크립트
# 작성자: Jeonghan Kim
# ==========================================

echo "🚀 TeX Live 설치를 시작합니다..."
cd ~

# 1️⃣ 설치 스크립트 다운로드
echo "📦 install-tl-unx.tar.gz 다운로드 중..."
wget -q https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

# 2️⃣ 압축 해제
echo "📂 압축 해제 중..."
tar -xzf install-tl-unx.tar.gz

# 3️⃣ install-tl-* 폴더로 이동 (정확히 하나 선택)
cd "$(ls -d install-tl-* | head -n 1)"

# 4️⃣ TeX Live 전체 버전 자동 설치
echo "⚙️  TeX Live 전체 버전 설치 중 (scheme-full)..."
sudo ./install-tl -scheme full -repository https://mirror.kakao.com/CTAN/systems/texlive/tlnet

# 5️⃣ 최신 설치 연도 감지
TEXLIVE_YEAR=$(ls /usr/local/texlive | grep -E "^[0-9]{4}$" | sort | tail -n 1)
if [ -z "$TEXLIVE_YEAR" ]; then
	  echo "❌ 설치 실패: /usr/local/texlive 폴더가 없습니다."
	    exit 1
fi

# 6️⃣ PATH 등록
echo "🧭 PATH에 TeX Live ${TEXLIVE_YEAR} 등록 중..."
if ! grep -q "texlive/${TEXLIVE_YEAR}/bin/x86_64-linux" ~/.bashrc; then
	  echo "export PATH=/usr/local/texlive/${TEXLIVE_YEAR}/bin/x86_64-linux:\$PATH" >> ~/.bashrc
fi
source ~/.bashrc

# 7️⃣ 패키지 관리자 업데이트
echo "🔄 패키지 관리자(tlmgr) 업데이트 중..."
sudo /usr/local/texlive/${TEXLIVE_YEAR}/bin/x86_64-linux/tlmgr update --self --all

# 8️⃣ 설치 확인
echo "✅ 설치 완료. 버전 확인:"
/usr/local/texlive/${TEXLIVE_YEAR}/bin/x86_64-linux/pdflatex --version

echo "🎉 TeX Live ${TEXLIVE_YEAR} 설치 및 설정이 완료되었습니다!"

