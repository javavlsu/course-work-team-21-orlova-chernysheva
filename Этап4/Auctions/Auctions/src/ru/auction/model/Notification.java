package ru.auction.model;

public class Notification {
    private long id;
    private User userId;
    private String content;

    public void setId(long id) {
        this.id = id;
    }
    public long getId() {
        return id;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }
    public User getUserId() {
        return userId;
    }

    public void setContent(String content) {
        this.content = content;
    }
    public String getContent() {
        return content;
    }
}
