#ifndef MOS_CALLBACK_H
#define MOS_CALLBACK_H
#include <string>

void print_wrapper(std::string) ;
void my_log_callback(struct mosquitto *mosq, void * obj, int level, const char * msg);
void my_connect_callback(struct mosquitto *mosq, void * obj, int rc);
void my_message_callback(struct mosquitto *mosq, void *obj, const struct mosquitto_message *msg) ;
void my_publish_callback (struct mosquitto * mosq, void * obj, int mid);
#endif
