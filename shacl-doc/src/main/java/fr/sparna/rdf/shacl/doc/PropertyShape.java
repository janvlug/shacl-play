package fr.sparna.rdf.shacl.doc;

import java.util.List;
import java.util.stream.Collectors;

import org.apache.jena.rdf.model.Literal;
import org.apache.jena.rdf.model.RDFList;
import org.apache.jena.rdf.model.RDFNode;
import org.apache.jena.rdf.model.Resource;
import org.topbraid.shacl.vocabulary.SH;

import fr.sparna.rdf.shacl.doc.read.PropertyShapeDocumentationBuilder;

public class PropertyShape {

	private Resource resource;

	// can be a URI or a blank node corresponding to a property path
	protected Resource shPath;

	protected Resource shDatatype;
	protected Resource shNodeKind;
	protected Integer shMinCount;
	protected Integer shMaxCount;
	// currently not used
	protected Literal shPattern;
	protected Resource shNode;
	protected Resource shClass;
	protected List<Literal> shName;
	protected List<Literal> rdfsLabel;
	protected List<Literal> skosDefinition;
	protected List<Literal> skosScopeNote;
	protected List<Literal> tooiFrbrScope;
	protected List<Literal> tooiCategorie;
	protected List<Literal> shDescription;
	protected List<RDFNode> shIn;
	protected Integer shOrder;
	protected RDFNode shValue;
	protected String localName;
	protected String nameSpace;


	protected List<Resource> shOr;

	public List<Resource> getShOr() {
		return shOr;
	}

	public void setShOr(List<Resource> shOr) {
		this.shOr = shOr;
	}

	public PropertyShape(Resource resource) {
		super();
		this.resource = resource;
	}

	public Resource getResource() {
		return resource;
	}
	public Resource getShPath() {
		return shPath;
	}

	public void setShPath(Resource shPath) {
		this.shPath = shPath;
	}

	public Resource getShDatatype() {
		return shDatatype;
	}
	public void setShDatatype(Resource shDatatype) {
		this.shDatatype = shDatatype;
	}
	public Resource getShNodeKind() {
		return shNodeKind;
	}
	public void setShNodeKind(Resource shNodeKind) {
		this.shNodeKind = shNodeKind;
	}

	public Integer getShMinCount() {
		return shMinCount;
	}

	public void setShMinCount(Integer shMinCount) {
		this.shMinCount = shMinCount;
	}

	public Integer getShMaxCount() {
		return shMaxCount;
	}

	public void setShMaxCount(Integer shMaxCount) {
		this.shMaxCount = shMaxCount;
	}

	// currently not used
	public Literal getShPattern() {
		return shPattern;
	}
	public void setShPattern(Literal shPattern) {
		this.shPattern = shPattern;
	}
	public Resource getShNode() {
		return shNode;
	}
	public void setShNode(Resource node) {
		this.shNode = node;
	}
	public Resource getShClass() {
		return shClass;
	}
	public void setShClass(Resource shClass) {
		this.shClass = shClass;
	}
	public List<Literal> getShName() {
		return shName;
	}
	public void setShName(List<Literal> shName) {
		this.shName = shName;
	}
	public List<Literal> getRdfsLabel() {
		return rdfsLabel;
	}
	public void setRdfsLabel(List<Literal> rdfsLabel) {
		this.rdfsLabel = rdfsLabel;
	}
	public List<Literal> getSkosDefinition() {
		return skosDefinition;
	}
	public  void setSkosDefinition(List<Literal> skosDefinition) {
		this.skosDefinition = skosDefinition;
	}
	public List<Literal> getSkosScopeNote() {
		return skosScopeNote;
	}
	public  void setSkosScopeNote(List<Literal> skosScopeNote) {
		this.skosScopeNote = skosScopeNote;
	}
	public List<Literal> getTooiFrbrScope() {
		return tooiFrbrScope;
	}
	public  void setTooiFrbrScope(List<Literal> tooiFrbrScope) {
		this.tooiFrbrScope = tooiFrbrScope;
	}
	public List<Literal> getTooiCategorie() {
		return tooiCategorie;
	}
	public  void setTooiCategorie(List<Literal> tooiCategorie) {
		this.tooiCategorie = tooiCategorie;
	}
	public List<Literal> getShDescription() {
		return shDescription;
	}
	public void setShDescription(List<Literal> shDescription) {
		this.shDescription = shDescription;
	}
	public List<RDFNode> getShIn() {
		return shIn;
	}
	public void setShIn(List<RDFNode> shIn) {
		this.shIn = shIn;
	}
	public Integer getShOrder() {
		return shOrder;
	}
	public void setShOrder(Integer shOrder) {
		this.shOrder = shOrder;
	}
	public RDFNode getShValue() {
		return shValue;
	}
	public void setShValue(RDFNode shValue) {
		this.shValue = shValue;
	}
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

	/**
	 * Returns the short form of the property or the property path already shortened
	 * @return
	 */
	public String getShPathAsString() {
		return (this.shPath.isURIResource())?PropertyShapeDocumentationBuilder.render(this.getShPath(), false):PropertyShape.renderShaclPropertyPath(this.getShPath());
	}

	public String getShNameAsString() {
		return PropertyShapeDocumentationBuilder.render(this.getShName(), true);
	}

	public String getRdfsLabelAsString() {
		return PropertyShapeDocumentationBuilder.render(this.getRdfsLabel(), true);
	}


	public static String renderShaclPropertyPath(Resource r) {
		if(r == null) return "";

		if(r.isURIResource()) {
			return r.getModel().shortForm(r.getURI());
		} else if(r.hasProperty(SH.alternativePath)) {
			Resource alternatives = r.getPropertyResourceValue(SH.alternativePath);
			RDFList rdfList = alternatives.as( RDFList.class );
			List<RDFNode> pathElements = rdfList.asJavaList();
			return pathElements.stream().map(p -> renderShaclPropertyPath((Resource)p)).collect(Collectors.joining("|"));
		} else if(r.hasProperty(SH.inversePath)) {
			Resource value = r.getPropertyResourceValue(SH.inversePath);
			if(value.isURIResource()) {
				return "^"+renderShaclPropertyPath(value);
			}
			else {
				return "^("+renderShaclPropertyPath(value)+")";
			}
		} else if(r.hasProperty(SH.zeroOrMorePath)) {
			Resource value = r.getPropertyResourceValue(SH.zeroOrMorePath);
			if(value.isURIResource()) {
				return renderShaclPropertyPath(value)+"*";
			}
			else {
				return "("+renderShaclPropertyPath(value)+")*";
			}
		} else if(r.hasProperty(SH.oneOrMorePath)) {
			Resource value = r.getPropertyResourceValue(SH.oneOrMorePath);
			if(value.isURIResource()) {
				return renderShaclPropertyPath(value)+"+";
			}
			else {
				return "("+renderShaclPropertyPath(value)+")+";
			}
		} else {
			return null;
		}
	}

}
