package board;

// 일기글에 사용할 모델 클래스입니다.
public class Article {
	private String comment;	// 내용
	private String photo;	// 일기에 등록한 이미지 이름
	
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
}