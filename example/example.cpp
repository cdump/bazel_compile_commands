#include <cstdio>

#include "rapidjson/rapidjson.h"
#include "rapidjson/stringbuffer.h"
#include "rapidjson/writer.h"

int main(int argc, char *argv[])
{
    rapidjson::StringBuffer sb;
    rapidjson::Writer<rapidjson::StringBuffer> w(sb);
    w.StartObject();
    w.Key("a");
    w.Double(42.1f);
    w.EndObject();
    w.Flush();
    printf("%s\n", sb.GetString());
    return 0;
}
