package com.hgu.guitar.vo;

import java.util.Date;

public class SheetVO {

    private Integer sheetId;
    private String title;
    private Date sheetDate;

    private String sheetFile;
    private String musicKey;

    private Integer codeId;      // code_table과 연결될 수 있음

    private String difficulty;
    private String commentText;
    private String stroke;

    private Date createdAt;

    public SheetVO() {
    }

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

    public Date getSheetDate() {
        return sheetDate;
    }

    public void setSheetDate(Date sheetDate) {
        this.sheetDate = sheetDate;
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

    public Integer getCodeId() {
        return codeId;
    }

    public void setCodeId(Integer codeId) {
        this.codeId = codeId;
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

    @Override
    public String toString() {
        return "SheetVO{" +
                "sheetId=" + sheetId +
                ", title='" + title + '\'' +
                ", sheetDate=" + sheetDate +
                ", sheetFile='" + sheetFile + '\'' +
                ", musicKey='" + musicKey + '\'' +
                ", codeId=" + codeId +
                ", difficulty='" + difficulty + '\'' +
                ", commentText='" + commentText + '\'' +
                ", stroke='" + stroke + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
