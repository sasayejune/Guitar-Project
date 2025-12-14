package com.hgu.guitar.vo;

import java.util.Date;
import java.util.List;

public class SheetVO {

    private Integer sheetId;
    private String title;
    private String sheetFile;
    private String musicKey;

    // ⭐⭐⭐ 다중 코드 연결
    private List<Integer> codeIds;

    private String difficulty;
    private String commentText;
    private String stroke;
    private Date createdAt;

    // ===== getter / setter =====

    public Integer getSheetId() {
        return sheetId;
    }

    public void setSheetId(Integer sheetId) {
        this.sheetId = sheetId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSheetFile() {
        return sheetFile;
    }

    public void setSheetFile(String sheetFile) {
        this.sheetFile = sheetFile;
    }

    public String getMusicKey() {
        return musicKey;
    }

    public void setMusicKey(String musicKey) {
        this.musicKey = musicKey;
    }

    public List<Integer> getCodeIds() {
        return codeIds;
    }

    public void setCodeIds(List<Integer> codeIds) {
        this.codeIds = codeIds;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public String getStroke() {
        return stroke;
    }

    public void setStroke(String stroke) {
        this.stroke = stroke;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
