enum UserType { provider, requester }
enum EntityType { solo, company }

UserType userTypeFromString(String s) =>
    s.toLowerCase() == 'provider' ? UserType.provider : UserType.requester;

EntityType entityTypeFromString(String s) =>
    s.toLowerCase() == 'company' ? EntityType.company : EntityType.solo;
