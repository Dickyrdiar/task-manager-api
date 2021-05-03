module AlgoliaSearchable
    include AlgoliaSearch 
    extend ActiveSupport::Concern 

    SEARCH_INDEX_SETTINGS = {
        id: search_id, 
        if: search_indexable?,
        index_name: "groups", 
        per_environment: true, 
        sanitize: true
    }

    SEARCH_ATTRIBUTES_TO_INDEX = [
        'name', 
        'symbol'
    ]

    SEARCH_ATTRIBUTES_TO_RETRIEVE = [
        'name', 
        'symbol'
    ]

    include do 
        algoliasearch AlgoliaSearchable::SEARCH_INDEX_SETTINGS do 
            attribute AlgoliaSearchable::SEARCH_ATTRIBUTES 
            attributestoIndex AlgoliaSearchable::SEARCH_ATTRIBUTES_TO_INDEX
            attributestoRetrieve AlgoliaSearchable::SEARCH_ATTRIBUTES_TO_RETRIEVE
        end 
    end 

    def search_id 
        "group_#{id}"
    end 

    def search_indexabele?
        name && symbol && id ? true : false 
    end 
end