#include <iostream>
#include "my_print/print_result.h"
#include "mos_utils/mos_callback.h"
#include "mosquitto.h"
using namespace std;

void print_wrapper(std::string msg) {
        print_result(msg);
}

void my_log_callback(struct mosquitto *mosq, void * obj, int level, const char * msg) {
        //Ignore level, just print it
        cout<<" Level:" << level <<" msg: " << msg << endl;
}

void my_connect_callback(struct mosquitto *mosq, void * obj, int rc) {
        if(rc !=0) {
                cout <<" Error: Connection failed, return code = "<< rc << endl;
        }

        cout <<"Connection success! Subscribe to test/topic\n";
        mosquitto_subscribe(mosq, NULL, "test/topic", 0);
}

void my_message_callback(struct mosquitto *mosq, void *obj, const struct mosquitto_message *msg) {
        cout << "New message with topic: " << msg->topic << " msg: " << (char *) msg->payload<< endl;
}

void my_publish_callback (struct mosquitto * mosq, void * obj, int mid) {
        cout<<"message id:" << mid <<endl;
}
