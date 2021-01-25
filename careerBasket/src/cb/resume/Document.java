package cb.resume;

import java.time.LocalDate;

public class Document {

	private int documentId;
	private String userId;
	private int resumeId;
	private String type;
	private String fileTitle;
	private String filePath;
	private String fileSize;
	private LocalDate wDate;
	public Document() {}
	public Document(int documentId, String userId, int resumeId, String type, String fileTitle, String filePath,
			String fileSize, LocalDate wDate) {
		super();
		this.documentId = documentId;
		this.userId = userId;
		this.resumeId = resumeId;
		this.type = type;
		this.fileTitle = fileTitle;
		this.filePath = filePath;
		this.fileSize = fileSize;
		this.wDate = wDate;
	}
	public int getDocumentId() {
		return documentId;
	}
	public void setDocumentId(int documentId) {
		this.documentId = documentId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getResumeId() {
		return resumeId;
	}
	public void setResumeId(int resumeId) {
		this.resumeId = resumeId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFileTitle() {
		return fileTitle;
	}
	public void setFileTitle(String fileTitle) {
		this.fileTitle = fileTitle;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public LocalDate getwDate() {
		return wDate;
	}
	public void setwDate(LocalDate wDate) {
		this.wDate = wDate;
	}
	@Override
	public String toString() {
		return "Document [documentId=" + documentId + ", userId=" + userId + ", resumeId=" + resumeId + ", type=" + type
				+ ", fileTitle=" + fileTitle + ", filePath=" + filePath + ", fileSize=" + fileSize + ", wDate=" + wDate
				+ "]";
	}
	
	
	
}
