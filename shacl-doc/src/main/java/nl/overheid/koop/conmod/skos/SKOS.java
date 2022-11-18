package nl.overheid.koop.conmod.skos;

import org.apache.jena.rdf.model.Property;
import org.apache.jena.rdf.model.ResourceFactory;

public class SKOS {
	
    public final static String BASE_URI = "http://www.w3.org/2004/02/skos/core#";
    
//    public final static String NAME = "SKOS";

    public final static String NS = BASE_URI;

    public final static Property definition = ResourceFactory.createProperty(NS + "definition");

    public final static Property scopeNote = ResourceFactory.createProperty(NS + "scopeNote");
}
