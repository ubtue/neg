package de.uni_tuebingen.ub.nppm.model;

import java.util.Set;
import org.json.*;

abstract public class SelektionHierarchy extends Selektion {
    abstract public SelektionHierarchy getParent();
    abstract public Set<? extends SelektionHierarchy> getChildren();

    public JSONObject toJSONObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", getId());
        jsonObject.put("bezeichnung", getBezeichnung());
        if (getParent() == null) {
            jsonObject.put("parent", JSONObject.NULL);
        } else {
            jsonObject.put("parent", getParent().toJSONObject());
        }

        /*
        // This section is not used in JSON and breaks the functionality,
        // so we disable it for now
        JSONArray childArray = new JSONArray();
        for (SelektionHierarchy child : getChildren()) {
            childArray.put(child.toJSONObject());
        }
        jsonObject.put("children", childArray);
        */

        return jsonObject;
    }
}
