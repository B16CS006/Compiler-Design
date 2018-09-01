#ifndef HASH_H
#define HASH_H

#define HASH_MAX 17

struct List{
	char value[256];
	struct List *next;
};

struct Hash{
	struct List *store[HASH_MAX];
};


///////////////////////////////////////////////////////////////member functions
/*
void append(struct List*, char*);
void delete(struct List*, char*);
_Bool find(struct List*, char*);
void print(struct List*);

/*
void insert_end(struct Hash*,char*,char*);
void delete(struct Hash*,char*,char*);
void find(struct Hash*, char*);
void print(struct Hash*);*/



void insert_hash(struct Hash* head,char* key,char* value);

void print_hash(struct Hash head);

struct Hash create_hash_table();


#endif
