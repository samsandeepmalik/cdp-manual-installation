# Create SSH key
ssh-keygen

# Install sshpass package
sudo yum -y install sshpass

# Copy SSH public key to all hosts
USER_NAME="ec2-user"
HOST_FILE="~/hosts"
ERROR_FILE="~/tmp/ssh-copy_error.txt"
PUBLIC_KEY_FILE="~/.ssh/id_rsa.pub

JDK_PACKAGE=java-1.8.0-openjdk-devel

if [ ! -f  $PUBLIC_KEY_FILE ]; then
        echo "File '$PUBLIC_KEY_FILE' not found!"
        exit 1
fi

if [ ! -f $HOST_FILE ]; then
        echo "File '$HOST_FILE' not found!"
        exit 2
fi

for IP in 'cat $HOST_FILE'; do
        ssh-copy-id -o StrictHostKeyChecking=no -i $PUBLIC_KEY_FILE $USER_NAME@$IP 2>$ERROR_FILE
        RESULT=$?
        if [ $RESULT -eq 0 ]; then
                echo ""
                echo "Public key successfully copied to $IP"
                echo ""
        else
                echo "$(cat  $ERROR_FILE)"
                echo 
                exit 3
        fi
        echo ""
done
