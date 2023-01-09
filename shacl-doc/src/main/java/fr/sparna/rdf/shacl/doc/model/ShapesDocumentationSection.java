package fr.sparna.rdf.shacl.doc.model;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;

@JsonInclude(Include.NON_NULL)
public class ShapesDocumentationSection {

	private String title;
	private String uri;
	private String localName;
	private String nameSpace;
	private String description;
	private String targetClassLabel;
	private String targetClassUri;
	private String pattern;
	private String nodeKind;
	private Boolean closed;
	private String skosDefinition;
	private String skosExample;
	private String skosNote;
	private String skosScopeNote;
	
	@JacksonXmlElementWrapper(localName="superClasses")
	@JacksonXmlProperty(localName = "link")
	private List<Link> superClasses;
	
	@JacksonXmlElementWrapper(localName="properties")
	@JacksonXmlProperty(localName = "property")
	public List<PropertyShapeDocumentation> propertySections;

	public void setLocalName(String localName) {
		this.localName = localName;
	}
	
	public String getLocalName() {
		return localName;
	}
	
	public void setNameSpace(String nameSpace) {
		this.nameSpace = nameSpace;
	}
	
	public String getNameSpace() {
		return nameSpace;
	}
	
	public List<Link> getSuperClasses() {
		return superClasses;
	}

	public void setSuperClasses(List<Link> superClasses) {
		this.superClasses = superClasses;
	}
	
	public String getSkosDefinition() {
		return skosDefinition;
	}

	public String getSkosExample() {
		return skosExample;
	}
	
	public String getSkosNote() {
		return skosNote;
	}
	
	public String getSkosScopeNote() {
		return skosScopeNote;
	}
	
	public void setSkosDefinition(String skosDefinition) {
		this.skosDefinition = skosDefinition;
	}

	public void setSkosExample(String skosExample) {
		this.skosExample = skosExample;
	}
	
	public void setSkosNote(String skosNote) {
		this.skosNote = skosNote;
	}
	
	public void setSkosScopeNote(String skosScopeNote) {
		this.skosScopeNote = skosScopeNote;
	}

	public String getTitle() {
		return title;		
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = uri;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getTargetClassLabel() {
		return targetClassLabel;
	}

	public void setTargetClassLabel(String targetClassLabel) {
		this.targetClassLabel = targetClassLabel;
	}
	
	public String getTargetClassUri() {
		return targetClassUri;
	}

	public void setTargetClassUri(String targetClassUri) {
		this.targetClassUri = targetClassUri;
	}
	
	public String getPattern() {
		return pattern;
	}

	public void setPattern(String pattern) {
		this.pattern = pattern;
	}
	
	public String getNodeKind() {
		return nodeKind;
	}

	public void setNodeKind(String nodeKind) {
		String value =null;
		if(nodeKind != null) {
			if(nodeKind.contains(":")) {
				value = nodeKind.split(":")[1];
			}else {
				value = nodeKind;
			}
			
		}
		this.nodeKind = nodeKind;
	}

	public Boolean getClosed() {
		return closed;
	}

	public void setClosed(Boolean closed) {
		this.closed = closed;
	}
	
	public List<PropertyShapeDocumentation> getPropertySections() {
		return propertySections;
	}
	public void setPropertySections(List<PropertyShapeDocumentation> propertySections) {
		this.propertySections = propertySections;
	}	
}
