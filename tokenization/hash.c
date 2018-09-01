
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "hash.h"


#define PREPROCESSORS		0
#define KEYWORDS		1
#define SEPARATORS 		2
#define CHAR			3
#define LITERALS		4
#define IDENTIFIERS 		5
#define ARITHMATIC_OPERATORS	6
#define LOGICAL_OPERATORS	7
#define RELATIONAL_OPERATORS	8
#define BITWISE_OPERATORS	9
#define ASSIGNMENT_OPERATORS	10
#define INC_DEC_OPERATORS	11
#define CONDITIONAL_OPERATORS	12
#define SPECIAL_OPERATORS	13
#define INT			14
#define FLOAT			15
#define ERRORS			16
	



/////////////////////////////////////////////////////////////////////////private functions

/*
void print_list(struct List *l);
void insert_list(struct List** l, char* s);
*/


char* Token[HASH_MAX] = {"Preprocessor","Keyword","Separator","Char","Literal","Identifier","Arithmetic_Operation","Logical_Operator","Relation_Operator","Bitwise_Operator",
			"Assignment_Operator","Inc_Dec_Operator","Conditional_Operator","Special_Operator","Int","Float","Error"};

int search(char* s){
	if(strcmp(s,"Preprocessor")==0) return PREPROCESSORS;
	if(strcmp(s,"Keyword")==0) return KEYWORDS;
	if(strcmp(s,"Separator")==0) return SEPARATORS;
	if(strcmp(s,"Char")==0) return CHAR;
	if(strcmp(s,"Literal")==0) return LITERALS;
	if(strcmp(s,"Identifier")==0) return IDENTIFIERS;
	if(strcmp(s,"Arithmatic_Operator")==0) return ARITHMATIC_OPERATORS;
	if(strcmp(s,"Logical_Operator")==0) return LOGICAL_OPERATORS;
	if(strcmp(s,"Relational_Operator")==0) return RELATIONAL_OPERATORS;
	if(strcmp(s,"Bitwise_Operator")==0) return BITWISE_OPERATORS;
	if(strcmp(s,"Assignment_Operator")==0) return ASSIGNMENT_OPERATORS;
	if(strcmp(s,"Inc_Dec_Operator")==0) return INC_DEC_OPERATORS;
	if(strcmp(s,"Conditional_Operator")==0) return CONDITIONAL_OPERATORS;
	if(strcmp(s,"Special_Operator")==0) return SPECIAL_OPERATORS;
	if(strcmp(s,"Int")==0) return INT;
	if(strcmp(s,"Float")==0) return FLOAT;
	if(strcmp(s,"Error")==0) return ERRORS;
	
	printf("Error in above line.\n");
	return -1;
}



void print_list(struct List *l){
	while(l!=NULL){
		printf("%s ",l->value);
		l = l -> next;
	}
	printf("\n");
}

void insert_list(struct List** l, char* s){
	struct List * new_node = (struct List*)malloc(sizeof(struct List));
	strcpy(new_node->value,s);
	new_node->next = NULL;
	
	if(*l==NULL){
		*l = new_node;
		return ;
	}
	struct List* temp = *l;
	while(temp->next != NULL)
		temp=temp->next;
	temp->next = new_node;
	return;
}



/////////////////////////////////////////////////////////////////////////////////Public Functions

/////////////////////////////////////Hash Functions

struct Hash create_hash_table(){
	struct Hash * hash = (struct Hash*)malloc(sizeof(struct Hash));
	for(int i = 0;i<HASH_MAX;i++)
		hash->store[i] = NULL;
	return *hash;
}

void print_hash(struct Hash head){
	for(int i = 0;i <HASH_MAX;i++){
		if(head.store[i] == NULL)			//a	
			continue;
		printf("%s : ",Token[i]);
		print_list(head.store[i]);
	}
}

void insert_hash(struct Hash* head,char* key,char* value){
	int index = search(key);
	if(index <0 || index >=HASH_MAX)return;
	insert_list(&(head->store[index]),value);
}





