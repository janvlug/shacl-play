package fr.sparna.rdf.shacl.doc.read;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.jena.rdf.model.Model;
import org.apache.jena.vocabulary.RDFS;

import fr.sparna.rdf.shacl.doc.ConstraintValueReader;
import fr.sparna.rdf.shacl.doc.NodeShape;
import fr.sparna.rdf.shacl.doc.PropertyShape;
import fr.sparna.rdf.shacl.doc.model.Link;
import fr.sparna.rdf.shacl.doc.model.PropertyShapeDocumentation;
import fr.sparna.rdf.shacl.doc.model.ShapesDocumentationSection;

public class ShapesDocumentationSectionBuilder {

	public static ShapesDocumentationSection build(
			NodeShape nodeShape,
			List<NodeShape> allNodeShapes,
			Model shaclGraph,
			Model owlGraph,
			String lang
	) {
		ShapesDocumentationSection currentSection = new ShapesDocumentationSection();
		
		// URI
		currentSection.setUri(nodeShape.getShortForm());
		
		// title : either rdfs:label or the URI short form
		currentSection.setTitle((nodeShape.getRdfsLabel() != null && !nodeShape.getRdfsLabel().isEmpty()) ? nodeShape.getRdfsLabel() : nodeShape.getShortForm());
		
		// rdfs:comment
		currentSection.setDescription(nodeShape.getRdfsComment());
		
		// sh:targetClass
		if(nodeShape.getShTargetClass() != null) {
			currentSection.setTargetClassLabel(nodeShape.getShTargetClass().getModel().shortForm(nodeShape.getShTargetClass().getURI()));
			currentSection.setTargetClassUri(nodeShape.getShTargetClass().getURI());
		}
		
		// sh:pattern
		currentSection.setPattern(nodeShape.getShPattern() != null?nodeShape.getShPattern().getString():null);
		
		// sh:nodeKind
		currentSection.setNodeKind(PropertyShapeDocumentationBuilder.renderNodeKind(nodeShape.getShNodeKind()));
		
		// sh:closed
		if(nodeShape.getShClosed() != null) {
			currentSection.setClosed(nodeShape.getShClosed());
		}
		
		// skos:definition
		currentSection.setSkosDefinition((nodeShape.getSkosDefinition() != null)?nodeShape.getSkosDefinition().toString():null);
		
		// skos:example
		currentSection.setSkosExample((nodeShape.getSkosExample() != null)?nodeShape.getSkosExample().toString():null);
		
		// skos:note
		currentSection.setSkosNote((nodeShape.getSkosNote() != null)?nodeShape.getSkosNote().toString():null);
		
		// skos:scopeNote
		currentSection.setSkosScopeNote((nodeShape.getSkosScopeNote() != null)?nodeShape.getSkosScopeNote().toString():null);
		
		// rdfs:subClassOf
		currentSection.setSuperClasses(nodeShape.getRdfsSubClassOf().stream()
				.filter(r -> allNodeShapes.stream().anyMatch(ns -> ns.getNodeShape().toString().equals(r.toString())))
				.map(r -> {
					// use the label if present, otherwise use the short form
					if(r.hasProperty(RDFS.label, lang)) {
						return new Link(
								"#"+r.getModel().shortForm(r.getURI()),
								ConstraintValueReader.readLiteralInLangAsString(r, RDFS.label, lang)
						);
					} else {
						return new Link(
								"#"+r.getModel().shortForm(r.getURI()),
								r.getModel().shortForm(r.getURI())
						);
					}
		}).collect(Collectors.toList()));
		
		// Read the property shapes
		List<PropertyShapeDocumentation> ListPropriete = new ArrayList<>();
		for (PropertyShape propriete : nodeShape.getProperties()) {
			PropertyShapeDocumentation psd = PropertyShapeDocumentationBuilder.build(propriete, allNodeShapes, shaclGraph, owlGraph, lang);				
			ListPropriete.add(psd);
		}
		
		currentSection.setPropertySections(ListPropriete);

		return currentSection;
	}
	
}
