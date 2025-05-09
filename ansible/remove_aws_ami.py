import boto3

ec2 = boto3.client('ec2')

def get_own_amis():
    images = ec2.describe_images(Owners=['self'])['Images']
    return sorted(images, key=lambda x: x['CreationDate'], reverse=True)

def delete_old_amis(keep_last_n=3):
    amis = get_own_amis()
    amis_to_delete = amis[keep_last_n:]

    for ami in amis_to_delete:
        ami_id = ami['ImageId']
        print(f"Удаляю AMI: {ami_id}")
        try:
            # Удаляем AMI
            ec2.deregister_image(ImageId=ami_id)

            # Ищем связанные snapshot'ы
            for mapping in ami.get('BlockDeviceMappings', []):
                ebs = mapping.get('Ebs')
                if ebs and 'SnapshotId' in ebs:
                    snapshot_id = ebs['SnapshotId']
                    print(f"  Удаляю snapshot: {snapshot_id}")
                    ec2.delete_snapshot(SnapshotId=snapshot_id)
        except Exception as e:
            print(f"Ошибка при удалении {ami_id}: {e}")

if __name__ == "__main__":
    delete_old_amis(keep_last_n=3)

