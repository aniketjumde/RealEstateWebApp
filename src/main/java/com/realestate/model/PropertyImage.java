package com.realestate.model;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="property_images")
public class PropertyImage 
{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="image_id")
	private int imageId;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="property_id", nullable = false)
	private Property property;
	
	@Lob
	@Column(name = "imageData")
	private byte[] imageData;
	    
	@CreationTimestamp
	@Column(name = "created_at")
	private LocalDateTime createdAt;
	    
	@UpdateTimestamp
	@Column(name="updated_at")
	private LocalDateTime updatedAt;
	
	//Constructor
	
	public PropertyImage() {}
	
	

	public PropertyImage(int imageId, Property property, byte[] imageData, LocalDateTime createdAt,
			LocalDateTime updatedAt) {
		super();
		this.imageId = imageId;
		this.property = property;
		this.imageData = imageData;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}



	//Getter and Setter

	public int getImageId() {
		return imageId;
	}

	public void setImageId(int imageId) {
		this.imageId = imageId;
	}

	public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	

	public byte[] getImageData() {
		return imageData;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }
	
	
}
