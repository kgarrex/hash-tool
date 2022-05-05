
struct endpoint {
    char *name;           // ex: \users\name
    int (*proc)(void *);
};


void add_endpoint(void *api, char *name, void *proc)
{

}

