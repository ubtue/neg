package de.uni_tuebingen.ub.nppm.model;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;
import java.util.Set;
import javax.persistence.*;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.json.*;

@MappedSuperclass
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
abstract public class SelektionHierarchy extends SelektionBezeichnung {
    abstract public SelektionHierarchy getParent();
    abstract public Set<? extends SelektionHierarchy> getChildren();

    public void iterateParents(Consumer<SelektionHierarchy> callback) {
        SelektionHierarchy parent = getParent();
        if (parent != null) {
            callback.accept(parent);
            parent.iterateParents(callback);
        }
    }

    public void iterateChildren(Consumer<SelektionHierarchy> callback) {
        for (SelektionHierarchy child : getChildren()) {
            callback.accept(child);
            child.iterateChildren(callback);
        }
    }

    /**
     * Get list of current ID + all children IDs, useful e.g. for search functionality.
     */
    public List<Integer> getSubtreeIdsRecursive() throws Exception {
        List<Integer> ids = new ArrayList<>();
        ids.add(getId());

        Consumer<SelektionHierarchy> helper = child -> ids.add(child.getId());
        iterateChildren(helper);

        return ids;
    }

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
