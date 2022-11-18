package nl.overheid.koop.conmod.tooi;

import org.apache.jena.rdf.model.Property;
import org.apache.jena.rdf.model.ResourceFactory;

public class Tooiont {
	
    public final static String BASE_URI = "https://identifier.overheid.nl/tooi/def/ont/";
    
//    public final static String NAME = "TOOI";

    public final static String NS = BASE_URI;

    public final static Property frbrscope = ResourceFactory.createProperty(NS + "frbr-scope");

    public final static Property categorie = ResourceFactory.createProperty(NS + "categorie");
}
