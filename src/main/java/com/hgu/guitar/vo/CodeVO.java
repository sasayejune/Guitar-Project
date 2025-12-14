package com.hgu.guitar.vo;

import java.util.Date;

public class CodeVO {

    private Integer codeId;

    // === 손가락 좌표 (비율값 0.0 ~ 1.0) ===
    private Double thumbX;
    private Double thumbY;

    private Double indexX;
    private Double indexY;

    private Double middleX;
    private Double middleY;

    private Double ringX;
    private Double ringY;

    private Double pinkyX;
    private Double pinkyY;

    // 엄지 개방 여부 (0 / 1)
    private Integer thumbOpen;

    // 코드 정보
    private String codeName;
    private String mp3Path;

    private Date createdAt;

    public CodeVO() {}

    // ===== getter / setter =====

    public Integer getCodeId() {
        return codeId;
    }

    public void setCodeId(Integer codeId) {
        this.codeId = codeId;
    }

    public Double getThumbX() {
        return thumbX;
    }

    public void setThumbX(Double thumbX) {
        this.thumbX = thumbX;
    }

    public Double getThumbY() {
        return thumbY;
    }

    public void setThumbY(Double thumbY) {
        this.thumbY = thumbY;
    }

    public Double getIndexX() {
        return indexX;
    }

    public void setIndexX(Double indexX) {
        this.indexX = indexX;
    }

    public Double getIndexY() {
        return indexY;
    }

    public void setIndexY(Double indexY) {
        this.indexY = indexY;
    }

    public Double getMiddleX() {
        return middleX;
    }

    public void setMiddleX(Double middleX) {
        this.middleX = middleX;
    }

    public Double getMiddleY() {
        return middleY;
    }

    public void setMiddleY(Double middleY) {
        this.middleY = middleY;
    }

    public Double getRingX() {
        return ringX;
    }

    public void setRingX(Double ringX) {
        this.ringX = ringX;
    }

    public Double getRingY() {
        return ringY;
    }

    public void setRingY(Double ringY) {
        this.ringY = ringY;
    }

    public Double getPinkyX() {
        return pinkyX;
    }

    public void setPinkyX(Double pinkyX) {
        this.pinkyX = pinkyX;
    }

    public Double getPinkyY() {
        return pinkyY;
    }

    public void setPinkyY(Double pinkyY) {
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
                ", codeName='" + codeName + '\'' +
                ", thumb=(" + thumbX + ", " + thumbY + ")" +
                ", index=(" + indexX + ", " + indexY + ")" +
                ", middle=(" + middleX + ", " + middleY + ")" +
                ", ring=(" + ringX + ", " + ringY + ")" +
                ", pinky=(" + pinkyX + ", " + pinkyY + ")" +
                ", thumbOpen=" + thumbOpen +
                ", mp3Path='" + mp3Path + '\'' +
                '}';
    }
}
