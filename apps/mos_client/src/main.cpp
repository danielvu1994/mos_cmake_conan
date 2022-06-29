#include <stdio.h>
#include "mosquitto.h"
#include "mos_utils/mos_callback.h"

int main(int argc, char *argv[])
{
        int i;
        char host[64];
        int port = 1883;
        int keepalive = 60;
        bool clean_session = true;
        struct mosquitto *mosq = NULL;
        char mqMsg[64] = {0,};

        sprintf(host, "broker.hivemq.com");

        mosquitto_lib_init();
        mosq = mosquitto_new(NULL, clean_session, NULL);

        if(!mosq){
                print_wrapper("Error: Out of memory.\n");
                return 1;
        }

        mosquitto_log_callback_set(mosq, my_log_callback);
        mosquitto_connect_callback_set(mosq, my_connect_callback);
        mosquitto_message_callback_set(mosq, my_message_callback);
        mosquitto_publish_callback_set(mosq, my_publish_callback);

        if(mosquitto_connect(mosq, host, port, keepalive)){
                print_wrapper("Unable to connect.\n");
                return 1;
        }


        mosquitto_loop_forever(mosq, -1, 1);

        mosquitto_destroy(mosq);
        mosquitto_lib_cleanup();
        return 0;
}
