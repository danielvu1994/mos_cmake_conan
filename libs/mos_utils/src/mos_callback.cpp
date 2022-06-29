#include "mos_utils/mos_callback.h"
#include "my_print/print_result.h"
#include "mosquitto.h"

void print_wrapper(std::string msg) {
        print_result(msg);
}

void my_log_callback(struct mosquitto *mosq, void * obj, int level, const char * msg) {
        //Ignore level, just print it
        fprintf(stderr, "level: %d, msg: %s \n", level, msg);
}

void my_connect_callback(struct mosquitto *mosq, void * obj, int rc) {
        if(rc !=0) {
                fprintf(stderr, "Connection failed, return code = %d \n", rc);
        }

        fprintf(stderr, "Connection success! Subscribe to test/topic\n");
        mosquitto_subscribe(mosq, NULL, "test/topic", 0);
}

void my_message_callback(struct mosquitto *mosq, void *obj, const struct mosquitto_message *msg) {
        fprintf(stderr, "New message with topic %s: %s\n", msg->topic, (char *) msg->payload);
}

void my_publish_callback (struct mosquitto * mosq, void * obj, int mid) {
        fprintf(stderr, "message id %d\n", mid);
}
