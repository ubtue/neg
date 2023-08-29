package de.uni_tuebingen.ub.nppm.model;

import java.util.Set;
import javax.persistence.*;
import org.json.*;

@MappedSuperclass
abstract public class SelektionHierarchy extends SelektionBezeichnung {
    abstract public SelektionHierarchy getParent();
    abstract public Set<? extends SelektionHierarchy> getChildren();

    public JSONObject toJSONObject(boolean ignore_parents, boolean ignore_children) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", getId());
        jsonObject.put("bezeichnung", getBezeichnung());

        if (!ignore_parents) {
            if (getParent() == null) {
                jsonObject.put("parent", JSONObject.NULL);
            } else {
                jsonObject.put("parent", getParent().toJSONObject(false, true));
            }
        }

        if (!ignore_children) {
            JSONArray childArray = new JSONArray();
            for (SelektionHierarchy child : getChildren()) {
                childArray.put(child.toJSONObject(true, false));
            }
            jsonObject.put("children", childArray);
        }

        return jsonObject;
    }

    public JSONObject toJSONObject() {
        return toJSONObject(false, false);
    }
}
