package fr.sparna.rdf.shacl.doc.model;

public class PropertyShapeDocumentation {

	private String label;
	
	// null if sh:path is a property path
	private Link propertyUri;
	private String expectedValueLabel;

	private String expectedValueAdditionnalInfoIn;
	private String expectedValueAdditionnalInfoValue;

	private String cardinalite;
	private String description;
	private String rangeclass;
	private String skosScopeNote;
	private String skosDefinition;
	private String tooiFrbrScope;
	private String tooiCategorie;
	private String localName;

	private String Or;

	private String linkNodeShape;
	private String linkNodeShapeUri;	
	
	
	public String getOr() {
		return Or;
	}

	public void setOr(String shOr) {
		this.Or = shOr;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public Link getPropertyUri() {
		return propertyUri;
	}

	public void setPropertyUri(Link propertyUri) {
		this.propertyUri = propertyUri;
	}

	public String getExpectedValueLabel() {
		return expectedValueLabel;
	}

	public String getExpectedValueAdditionnalInfoIn() {
		return expectedValueAdditionnalInfoIn;
	}

	public void setExpectedValueAdditionnalInfoIn(String expectedValueAdditionnalInfoIn) {
		this.expectedValueAdditionnalInfoIn = expectedValueAdditionnalInfoIn;
	}

	public String getExpectedValueAdditionnalInfoValue() {
		return expectedValueAdditionnalInfoValue;
	}

	public void setExpectedValueAdditionnalInfoValue(String expectedValueAdditionnalInfoValue) {
		this.expectedValueAdditionnalInfoValue = expectedValueAdditionnalInfoValue;
	}

	public String getCardinalite() {
		return cardinalite;
	}

	public void setExpectedValueLabel(String expectedValueLabel) {
		this.expectedValueLabel = expectedValueLabel;
	}

	public void setCardinalite(String cardinalite) {
		this.cardinalite = cardinalite;
	}

	public String getDescription() {
		return description;
	}
	
	public String getSkosScopeNote() {
		return skosScopeNote;
	}
	
	public String getTooiFrbrScope() {
		return tooiFrbrScope;
	}
	
	public String getTooiCategorie() {
		return tooiCategorie;
	}
	
	public String getLocalName() {
		return localName;
	}
	
	public String getSkosDefinition() {
		return skosDefinition;
	}
	
	public String getRangeClass() {
		return rangeclass;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public void setSkosScopeNote(String skosScopeNote) {
		this.skosScopeNote = skosScopeNote;
	}
	
	public void setSkosDefinition(String skosDefinition) {
		this.skosDefinition = skosDefinition;
	}
	
	public void setTooiFrbrScope(String tooiFrbrScope) {
		this.tooiFrbrScope = tooiFrbrScope;
	}
	
	public void setTooiCategorie(String tooiCategorie) {
		this.tooiCategorie = tooiCategorie;
	}
	
	public void setLocalName(String localName) {
		this.localName = localName;
	}
	
	public void setRangeClass(String rangeclass) {
		this.rangeclass = rangeclass;
	}

	public String getLinkNodeShape() {
		return linkNodeShape;
	}

	public void setLinkNodeShape(String linkNodeShape) {
		this.linkNodeShape = linkNodeShape;
	}

	public String getLinkNodeShapeUri() {
		return linkNodeShapeUri;
	}

	public void setLinkNodeShapeUri(String linkNodeShapeUri) {
		this.linkNodeShapeUri = linkNodeShapeUri;
	}

}
