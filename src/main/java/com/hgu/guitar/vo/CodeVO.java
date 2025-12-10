package com.hgu.guitar.vo;

import java.util.Date;

public class CodeVO {

    private Integer codeId;

    private Integer thumbX;
    private Integer thumbY;

    private Integer indexX;
    private Integer indexY;

    private Integer middleX;
    private Integer middleY;

    private Integer ringX;
    private Integer ringY;

    private Integer pinkyX;
    private Integer pinkyY;

    private Integer thumbOpen;   // 0/1

    private String mp3Path;
    private String codeName;

    private Date createdAt;

    public CodeVO() {
    }

    public Integer getCodeId() {
        return codeId;
    }

    public void setCodeId(Integer codeId) {
        this.codeId = codeId;
    }

    public Integer getThumbX() {
        return thumbX;
    }

    public void setThumbX(Integer thumbX) {
        this.thumbX = thumbX;
    }

    public Integer getThumbY() {
        return thumbY;
    }

    public void setThumbY(Integer thumbY) {
        this.thumbY = thumbY;
    }

    public Integer getIndexX() {
        return indexX;
    }

    public void setIndexX(Integer indexX) {
        this.indexX = indexX;
    }

    public Integer getIndexY() {
        return indexY;
    }

    public void setIndexY(Integer indexY) {
        this.indexY = indexY;
    }

    public Integer getMiddleX() {
        return middleX;
    }

    public void setMiddleX(Integer middleX) {
        this.middleX = middleX;
    }

    public Integer getMiddleY() {
        return middleY;
    }

    public void setMiddleY(Integer middleY) {
        this.middleY = middleY;
    }

    public Integer getRingX() {
        return ringX;
    }

    public void setRingX(Integer ringX) {
        this.ringX = ringX;
    }

    public Integer getRingY() {
        return ringY;
    }

    public void setRingY(Integer ringY) {
        this.ringY = ringY;
    }

    public Integer getPinkyX() {
        return pinkyX;
    }

    public void setPinkyX(Integer pinkyX) {
        this.pinkyX = pinkyX;
    }

    public Integer getPinkyY() {
        return pinkyY;
    }

    public void setPinkyY(Integer pinkyY) {
        this.pinkyY = pinkyY;
    }

    public Integer getThumbOpen() {
        return thumbOpen;
    }

    public void setThumbOpen(Integer thumbOpen) {
        this.thumbOpen = thumbOpen;
    }

    public String getMp3Path() {
        return mp3Path;
    }

    public void setMp3Path(String mp3Path) {
        this.mp3Path = mp3Path;
    }

    public String getCodeName() {
        return codeName;
    }

    public void setCodeName(String codeName) {
        this.codeName = codeName;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "CodeVO{" +
                "codeId=" + codeId +
                ", thumbX=" + thumbX +
                ", thumbY=" + thumbY +
                ", indexX=" + indexX +
                ", indexY=" + indexY +
                ", middleX=" + middleX +
                ", middleY=" + middleY +
                ", ringX=" + ringX +
                ", ringY=" + ringY +
                ", pinkyX=" + pinkyX +
                ", pinkyY=" + pinkyY +
                ", thumbOpen=" + thumbOpen +
                ", mp3Path='" + mp3Path + '\'' +
                ", codeName='" + codeName + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
