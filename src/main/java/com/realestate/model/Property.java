package com.realestate.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.realestate.enums.PropertyVerificationStatus;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

@Entity
public class Property 
{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="property_id")
	private Integer id;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	private User user;
	
	@Column(name = "title", nullable = false)
	private String title;
	
	@Column(name="description")
	private String description;
	
	@Column(name="property_type")
	private String propertyType;
	
	 @Column(name = "purpose", length = 10)
	 private String purpose; 
	
	@Column(name="price")
	private Double price;
	
	@Column(name="area_sqft")
	private Integer areaSqarefit;
	
	 
    @Column(name="Property_Status")
    private String propetystatus;
    
	
    @Column(name = "bedrooms")
	private int bedrooms;
	
    @Column(name = "bathrooms")
	private int bathrooms;
	
    @Column(name = "address")	
	private String address;
	
    @Column(name = "city")
    private String city;

    @Column(name = "state")
    private String state;

    @Column(name = "pincode", length = 10)
    private String pincode;

    @Column(name = "latitude")
    private String latitude;

    @Column(name = "longitude")
    private String longitude;
   
	
    @Enumerated(EnumType.STRING)
    @Column(name="property_Verification_status")
    private PropertyVerificationStatus verification;
	
	@CreationTimestamp
	@Column(name = "created_at")
	private LocalDateTime createdAt;
	    
	@UpdateTimestamp
	@Column(name="updated_at")
	private LocalDateTime updatedAt;
	
	@OneToMany(mappedBy = "property", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PropertyImage> images = new ArrayList<>();

    @OneToMany(mappedBy = "property", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Inquiry> inquiries = new ArrayList<>();
    
    
    //Constructor
    public Property() {}

	public Property(Integer id, User user, String title, String description, String propertyType, String purpose,
			Double price, Integer areaSqarefit, String propetystatus, int bedrooms, int bathrooms, String address,
			String city, String state, String pincode, String latitude, String longitude,
			PropertyVerificationStatus verification, LocalDateTime createdAt, LocalDateTime updatedAt,
			List<PropertyImage> images, List<Inquiry> inquiries) {
		super();
		this.id = id;
		this.user = user;
		this.title = title;
		this.description = description;
		this.propertyType = propertyType;
		this.purpose = purpose;
		this.price = price;
		this.areaSqarefit = areaSqarefit;
		this.propetystatus = propetystatus;
		this.bedrooms = bedrooms;
		this.bathrooms = bathrooms;
		this.address = address;
		this.city = city;
		this.state = state;
		this.pincode = pincode;
		this.latitude = latitude;
		this.longitude = longitude;
		this.verification = verification;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.images = images;
		this.inquiries = inquiries;
	}
	
	//Setter and Getter

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPropertyType() {
		return propertyType;
	}

	public void setPropertyType(String propertyType) {
		this.propertyType = propertyType;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Integer getAreaSqarefit() {
		return areaSqarefit;
	}

	public void setAreaSqarefit(Integer areaSqarefit) {
		this.areaSqarefit = areaSqarefit;
	}

	public String getPropetystatus() {
		return propetystatus;
	}

	public void setPropetystatus(String propetystatus) {
		this.propetystatus = propetystatus;
	}

	public int getBedrooms() {
		return bedrooms;
	}

	public void setBedrooms(int bedrooms) {
		this.bedrooms = bedrooms;
	}

	public int getBathrooms() {
		return bathrooms;
	}

	public void setBathrooms(int bathrooms) {
		this.bathrooms = bathrooms;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public PropertyVerificationStatus getVerification() {
		return verification;
	}

	public void setVerification(PropertyVerificationStatus verification) {
		this.verification = verification;
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

	public List<PropertyImage> getImages() {
		return images;
	}

	public void setImages(List<PropertyImage> images) {
		this.images = images;
	}

	public List<Inquiry> getInquiries() {
		return inquiries;
	}

	public void setInquiries(List<Inquiry> inquiries) {
		this.inquiries = inquiries;
	}

	

	 // Helper methods 
    public void addImage(PropertyImage image) {
        images.add(image);
        image.setProperty(this);
    }

    public void removeImage(PropertyImage image) {
        images.remove(image);
        image.setProperty(null);
    }

    public void addInquiry(Inquiry inquiry) {
        inquiries.add(inquiry);
        inquiry.setProperty(this);
    }

  
	
}
