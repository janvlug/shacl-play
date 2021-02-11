package fr.sparna.rdf.shacl.doc;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang3.ObjectUtils;
import org.apache.jena.graph.Node;
import org.apache.jena.rdf.listeners.NullListener;
import org.apache.jena.rdf.model.Property;
import org.apache.jena.rdf.model.RDFList;
import org.apache.jena.rdf.model.RDFNode;
import org.apache.jena.rdf.model.Resource;
import org.apache.jena.rdf.model.Statement;
import org.apache.jena.util.Metadata;
import org.apache.jena.util.iterator.ExtendedIterator;
import org.apache.jena.vocabulary.RDF;
import org.apache.jena.vocabulary.RDFS;
import org.topbraid.jenax.util.JenaUtil;
import org.topbraid.shacl.vocabulary.SH;

public class ShaclBox {

	private Resource nodeShape;
	protected String nameshape;
	List<ShaclProperty> shacl_value = new ArrayList<>();
	protected String shaclpatternNodeShape;
	protected String nametargetclass;
	protected String rdfsComment;
	protected String rdfslabel;

	public ShaclBox(Resource nodeShape, String lang) {
		this.nodeShape = nodeShape;
		this.setNameshape(nodeShape.getLocalName());
		this.setNametargetclass(nodeShape);
		this.setRdfsComment(nodeShape);
		this.setRdfslabel(nodeShape);
		this.setShaclpatternNodeShape(nodeShape);
	}
	
	
	

	public String getShaclpatternNodeShape() {
		return shaclpatternNodeShape;
	}


	public void setShaclpatternNodeShape(Resource nodeShape) {
		String value = null;
		ConstraintValueReader constraintValueReader = new ConstraintValueReader();
		value = constraintValueReader.readValueconstraint(nodeShape, SH.pattern);
		this.shaclpatternNodeShape = value;
	}





	public String getRdfslabel() {
		return rdfslabel;
	}

	public void setRdfslabel(Resource nodeShape) {
		String value = null;
		value = JenaUtil.getStringProperty(nodeShape, RDFS.label);
		this.rdfslabel = value;
	}

	public String getRdfsComment() {
		return rdfsComment;
	}

	public void setRdfsComment(Resource nodeShape) {
		String value = null;
		value = JenaUtil.getStringProperty(nodeShape, RDFS.comment);
		this.rdfsComment = value;
	}

	public String getNameshape() {
		return nameshape;
	}

	public void setNameshape(String nameshape) {

		this.nameshape = nameshape;
	}

	public List<ShaclProperty> getProperties() {
		return shacl_value;
	}

		public String getNametargetclass() {
		return nametargetclass;
	}

	public void setNametargetclass(Resource nodeShape) {
		ConstraintValueReader constargetclass = new ConstraintValueReader();
		this.nametargetclass = constargetclass.readValueconstraint(nodeShape, SH.targetClass);
	}

	
	public Resource getNodeShape() {
		return nodeShape;
	}

	public void setNodeShape(Resource nodeShape) {

		this.nodeShape = nodeShape;
	}
	
	public void readProperties(Resource nodeShape, List<ShaclBox> allBoxes, String lang) {
		String value_pattern_nodeshape;

		List<Statement> propertyStatements = nodeShape.listProperties(SH.property).toList();
		List<ShaclProperty> shacl_value = new ArrayList<>();
		for (Statement aPropertyStatement : propertyStatements) {
			RDFNode object = aPropertyStatement.getObject();

			if (object.isLiteral()) {
				System.out.println("Problem !");
			}

			Resource propertyShape = object.asResource();
			ShaclProperty plantvalueproperty = new ShaclProperty(propertyShape, allBoxes, lang);
			shacl_value.add(plantvalueproperty);
		}
		shacl_value.sort(Comparator.comparing(ShaclProperty::getShOrder));
		this.shacl_value = shacl_value;
	}
	
	
	public static List<RDFNode> asJavaList( Resource resource )
	  {
	  return (resource.as( RDFList.class )).asJavaList();
	  }
	

}