package cb.search;
//화면 보여주기 위해 필요한 데이터 담는 클래스

import java.util.List;

public class HireListView {
	private int hireTotalCnt;//채용공고 전체 개수 (쿼리 count로 세기)
	private int currentPageNum;//현재페이지 번호
	private List<HireInfo> hireList;//한페이지 당 보여줄 채용공고 리스트
	private int hireCntPerPage;//한페이지당 채용공고 개수
	private int firstRow;//화면에서 첫번째 채용공고 row번호
	
	private int pageTotalCnt;//전체 페이지 개수
	//여기 밑에 것들 추가함!
	//화면당 페이지 수 -> 3개로 설정
	public static final int BLOCK_SCALE = 3;
	private int prevPage;
	private int nextPage;
	private int totBlock;
	private int curBlock;
	private int prevBlock;
	private int nextBlock;
	//밑에 두개는 필요없는듯?
	private int pageBegin;
	private int pageEnd;
	//위에 두개 
	private int blockBegin;
	private int blockEnd;
	
	public HireListView() {}

	//생성자
	public HireListView(int hireTotalCnt, int currentPageNum, List<HireInfo> hireList, int hireCntPerPage,
			int firstRow) {
		//전체 페이지 개수는 리스트 개수따라 변하기 때문에
		//생성자로 입력받을 수 없다!
		//따로 로직으로 값을 넣어줘야함
		
		//이거 왜하는 거?
		curBlock = 1; //현재 페이지 블록 번호
		
		this.hireTotalCnt = hireTotalCnt;
		this.currentPageNum = currentPageNum;
		this.hireList = hireList;
		this.hireCntPerPage = hireCntPerPage;
		this.firstRow = firstRow;
		
		//페이지 전체개수 구하기
		//채용공고 전체 개수 /나누기 한페이지당 채용공고 개수 
		//나머지가 있다면-> 올림한 값을 페이지 전체 개수로
		//아니라면 -> 몫을 페이지 전체 개수로
		if(hireTotalCnt == 0) {
			pageTotalCnt=0;
		}else {
			pageTotalCnt = hireTotalCnt / hireCntPerPage;
			if(hireTotalCnt % hireCntPerPage >0) {
				pageTotalCnt++; //1증가
			}
		}
		
		setTotBlock(); //전체 페이지 블록 갯수 계산
		setBlockRange(); //페이지 블록의 시작,끝 번호 계산
		
		
	}
	
	//블록 범위 값 셋팅하는 메서드
	public void setBlockRange() {
		//현재 페이지가 몇번 째 페이지 블록에 속하는지 계산
		// (현재페이지-1)/페이지 블록단위+1
		curBlock = (int)Math.ceil((currentPageNum-1) / BLOCK_SCALE) + 1;
		
		//현재 페이지 블록의 시작 번호 계산
		// (현재블록-1)*블록단위+1
		blockBegin = (curBlock-1) * BLOCK_SCALE + 1;
		
		//페이지 블록의 끝번호
		// 블록시작번호+블록단위-1;
		blockEnd = blockBegin + BLOCK_SCALE - 1;
		
		//마지막 블록이 범위를 초과하지 않도록 계산
		if(blockEnd > pageTotalCnt) {
			blockEnd = pageTotalCnt;
		}
		
		//이전을 눌렀을 때 이동할 페이지 번호
		prevPage = (currentPageNum == 1)? 1:(curBlock-1)*BLOCK_SCALE;
		
		//다음을 눌렀을 때 이동할 페이지 번호
		nextPage = curBlock > totBlock ? (curBlock*BLOCK_SCALE) : (curBlock*BLOCK_SCALE)+1;
		
		//마지막 페이지가 범위를 초과하지 않도록 처리
		if(nextPage >= pageTotalCnt) {
			nextPage = pageTotalCnt;
		}
	}

	//getter & setter
	
	public int getHireTotalCnt() {
		return hireTotalCnt;
	}

	public void setHireTotalCnt(int hireTotalCnt) {
		this.hireTotalCnt = hireTotalCnt;
	}

	public int getCurrentPageNum() {
		return currentPageNum;
	}

	public void setCurrentPageNum(int currentPageNum) {
		this.currentPageNum = currentPageNum;
	}

	public List<HireInfo> getHireList() {
		return hireList;
	}

	public void setHireList(List<HireInfo> hireList) {
		this.hireList = hireList;
	}

	public int getHireCntPerPage() {
		return hireCntPerPage;
	}

	public void setHireCntPerPage(int hireCntPerPage) {
		this.hireCntPerPage = hireCntPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public void setFirstRow(int firstRow) {
		this.firstRow = firstRow;
	}

	public int getPageTotalCnt() {
		return pageTotalCnt;
	}

	public void setPageTotalCnt(int pageTotalCnt) {
		this.pageTotalCnt = pageTotalCnt;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getTotBlock() {
		return totBlock;
	}
	
	//페이지  블록의 개수 계산(총 10페이지라면 4개의 블록)
	public void setTotBlock() {
		//10/3 = 3.333 -> 4로 올림
		totBlock = (int)Math.ceil(pageTotalCnt / BLOCK_SCALE);
	}

	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getPrevBlock() {
		return prevBlock;
	}

	public void setPrevBlock(int prevBlock) {
		this.prevBlock = prevBlock;
	}

	public int getNextBlock() {
		return nextBlock;
	}

	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}

	public int getPageBegin() {
		return pageBegin;
	}

	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public int getBlockBegin() {
		return blockBegin;
	}

	public void setBlockBegin(int blockBegin) {
		this.blockBegin = blockBegin;
	}

	public int getBlockEnd() {
		return blockEnd;
	}

	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}

	public static int getBlockScale() {
		return BLOCK_SCALE;
	}

	@Override
	public String toString() {
		return "HireListView [hireTotalCnt=" + hireTotalCnt + ", currentPageNum=" + currentPageNum + ", hireList="
				+ hireList + ", hireCntPerPage=" + hireCntPerPage + ", firstRow=" + firstRow + ", pageTotalCnt="
				+ pageTotalCnt + ", prevPage=" + prevPage + ", nextPage=" + nextPage + ", totBlock=" + totBlock
				+ ", curBlock=" + curBlock + ", prevBlock=" + prevBlock + ", nextBlock=" + nextBlock + ", pageBegin="
				+ pageBegin + ", pageEnd=" + pageEnd + ", blockBegin=" + blockBegin + ", blockEnd=" + blockEnd + "]";
	}
	
	
	
	
	
}
