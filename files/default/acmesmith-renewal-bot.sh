!# /bin/bash

acmesmith renew
acmesmith save-certificate <%= @common_name %> --output=@certificate_path
acmesmith save-private-key <%= @common_name %> --output=@private_key_path
acmesmith save-pkcs12 <%= @common_name %> --output=@pkcs12_path


while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -n|--commonname)
    COMMONNAME="$2"
    shift # past argument
    ;;
    -c|--certificatepath)
    CERTIFICATEPATH="$2"
    shift # past argument
    ;;
    -p|--privatekeypath)
    PRIVATEKEYPATH="$2"
    shift # past argument
    ;;
    -k|--pkcspath)
    PKCSPATH="$2"
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

acmesmith autorenew
acmesmith save-certificate ${COMMONNAME} --output=${CERTIFICATEPATH}
acmesmith save-private-key ${COMMONNAME} --output=${PRIVATEKEYPATH}
acmesmith save-pkcs12 ${COMMONNAME} --output=${PKCSPATH}
