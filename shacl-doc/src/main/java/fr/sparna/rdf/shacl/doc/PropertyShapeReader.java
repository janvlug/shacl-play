package fr.sparna.rdf.shacl.doc;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.apache.jena.rdf.model.Literal;
import org.apache.jena.rdf.model.RDFList;
import org.apache.jena.rdf.model.RDFNode;
import org.apache.jena.rdf.model.Resource;
import org.topbraid.shacl.vocabulary.SH;
import nl.overheid.koop.conmod.skos.SKOS;
import nl.overheid.koop.conmod.tooi.Tooiont;

public class PropertyShapeReader {
	
	protected String lang;
	protected List<NodeShape> allBoxes;

	public PropertyShapeReader(String lang, List<NodeShape> allBoxes) {
		super();
		this.lang = lang;
		this.allBoxes = allBoxes;
	}

	public PropertyShape read(Resource constraint) {

		PropertyShape shaclProperty = new PropertyShape(constraint);
		
		shaclProperty.setLocalName (constraint.getLocalName());

		shaclProperty.setShPath(this.readShPath(constraint));
		shaclProperty.setShDatatype(this.readShDatatype(constraint));
		shaclProperty.setShNodeKind(this.readShNodeKind(constraint));
		shaclProperty.setShMinCount(this.readShMinCount(constraint));
		shaclProperty.setShMaxCount(this.readShMaxCount(constraint));
		shaclProperty.setShNode(this.readNode(constraint));
		shaclProperty.setShPattern(this.readShPattern(constraint));
		shaclProperty.setShClass(this.readShClass(constraint));
		shaclProperty.setShDescription(this.readDescription(constraint));
		shaclProperty.setShName(this.readName(constraint));
		shaclProperty.setShIn(this.readShin(constraint));
		shaclProperty.setShValue(this.readShValue(constraint));
		shaclProperty.setShOrder(this.readShOrder(constraint));
		shaclProperty.setShOr(this.readShOr(constraint));
		shaclProperty.setSkosDefinition(this.readSkosDefinition(constraint));
		shaclProperty.setSkosScopeNote(this.readSkosScopeNote(constraint));
		shaclProperty.setTooiFrbrScope(this.readTooiFrbrScope(constraint));
		shaclProperty.setTooiCategorie(this.readTooiCategorie(constraint));		
		
		return shaclProperty;
	}
	
	
	
	public List<Resource> readShOr(Resource constraint) {
		if (constraint.hasProperty(SH.or)) {			
			Resource list = constraint.getProperty(SH.or).getList().asResource();
			List<RDFNode> rdflist = list.as(RDFList.class).asJavaList();

			// read only the sh:node on list items
			return rdflist.stream().map(item -> {
				if(item.isResource()) {
					if(item.asResource().hasProperty(SH.node)) {
						return item.asResource().getPropertyResourceValue(SH.node);
					} else if(item.asResource().hasProperty(SH.class_)) {
						return item.asResource().getPropertyResourceValue(SH.class_);
					} else if(item.asResource().hasProperty(SH.datatype)) {
						return item.asResource().getPropertyResourceValue(SH.datatype);
					} else {
						return null;
					}
				} else {
					return null;
				}
			}).collect(Collectors.toList());
		} else {
			return null;
		}
	}

	public RDFNode readShValue(Resource constraint) {
		return Optional.ofNullable(constraint.getProperty(SH.hasValue)).map(s -> s.getObject()).orElse(null);
	}

	public Integer readShOrder(Resource constraint) {
		return Optional.ofNullable(constraint.getProperty(SH.order)).map(s -> Integer.parseInt(s.getString())).orElse(null);
	}

	public List<RDFNode> readShin(Resource constraint) {
		if (constraint.hasProperty(SH.in)) {
			Resource list = constraint.getProperty(SH.in).getList().asResource();
			return list.as(RDFList.class).asJavaList();
		} else {
			return null;
		}
	}

	public List<Literal> readName(Resource constraint) {
		return ConstraintValueReader.readLiteralInLang(constraint, SH.name, this.lang);
	}
	
	public List<Literal> readSkosDefinition(Resource constraint) {
		return ConstraintValueReader.readLiteralInLang(constraint, SKOS.definition, this.lang);
	}
	
	public List<Literal> readSkosScopeNote(Resource constraint) {
		return ConstraintValueReader.readLiteralInLang(constraint, SKOS.scopeNote, this.lang);
	}
	
	public List<Literal> readTooiFrbrScope(Resource constraint) {
		return ConstraintValueReader.readLiteralInLang(constraint, Tooiont.frbrscope, this.lang);
	}
	
	public List<Literal> readTooiCategorie(Resource constraint) {
		return ConstraintValueReader.readLiteralInLang(constraint, Tooiont.categorie, this.lang);
	}

	public List<Literal> readDescription(Resource constraint) {
		return ConstraintValueReader.readLiteralInLang(constraint, SH.description, this.lang);
	}

	public Resource readShPath(Resource constraint) {
		return Optional.ofNullable(constraint.getProperty(SH.path)).map(s -> s.getResource()).orElse(null);
	}

	public Resource readShDatatype(Resource constraint) {
		return Optional.ofNullable(constraint.getProperty(SH.datatype)).map(s -> s.getResource()).orElse(null);
	}

	public Resource readShNodeKind(Resource constraint) {		
		return Optional.ofNullable(constraint.getProperty(SH.nodeKind)).map(s -> s.getResource()).orElse(null);
	}

	
	public Integer readShMinCount(Resource constraint) {
		return Optional.ofNullable(constraint.getProperty(SH.minCount)).map(s -> Integer.parseInt(s.getString())).orElse(null);
	}
	
	public Integer readShMaxCount(Resource constraint) {
		return Optional.ofNullable(constraint.getProperty(SH.maxCount)).map(s -> Integer.parseInt(s.getString())).orElse(null);
	}

	public Literal readShPattern(Resource constraint) {
		return Optional.ofNullable(constraint.getProperty(SH.pattern)).map(s -> s.getLiteral()).orElse(null);
	}

	// TODO : devrait retourner un ShaclBox
	public Resource readNode(Resource constraint) {
		return Optional.ofNullable(constraint.getProperty(SH.node)).map(s -> s.getResource()).orElse(null);
	}

	public Resource readShClass(Resource constraint) {
		return Optional.ofNullable(constraint.getProperty(SH.class_)).map(s -> s.getResource()).orElse(null);
	}

}
