
# Create your models here.
from django.db import models

class MasterAll(models.Model):
    row_id = models.AutoField(primary_key=True)
    mth = models.CharField(max_length=10, null=True)
    did = models.CharField(max_length=50, null=True)
    ddp = models.CharField(max_length=50, null=True)
    accepted = models.CharField(max_length=50, null=True)
    BUDGET = models.CharField(max_length=50, null=True)
    PROJCODE = models.CharField(max_length=50, null=True)
    COMLIACODE = models.CharField(max_length=50, null=True)
    CTRLID = models.CharField(max_length=50, null=True)
    BATCH = models.CharField(max_length=50, null=True)
    MONTH = models.CharField(max_length=10, null=True)
    CDA = models.CharField(max_length=50, null=True)
    SECTION = models.CharField(max_length=50, null=True)
    VRCLASS = models.CharField(max_length=50, null=True)
    VRNO = models.CharField(max_length=50, null=True)
    RC1 = models.CharField(max_length=10, null=True)
    CAT1 = models.CharField(max_length=50, null=True)
    CODEHEAD = models.CharField(max_length=50, null=True)
    SIGN = models.CharField(max_length=50, null=True)
    AMT = models.DecimalField(max_digits=15, decimal_places=2, null=True)
    RESCDA = models.CharField(max_length=50, null=True)
    RESCDASEC = models.CharField(max_length=50, null=True)
    UNITIDIMP = models.CharField(max_length=50, null=True)
    DATE = models.DateField(null=True)
    fortnight = models.CharField(max_length=10, null=True)
    mon = models.CharField(max_length=10, null=True)
    year = models.IntegerField(null=True)
    BACKUPFLG = models.CharField(max_length=10, null=True)
    userid = models.CharField(max_length=50, null=True)
    timemodifed = models.DateTimeField(null=True)
    impid = models.CharField(max_length=50, null=True)
    billno = models.CharField(max_length=50, null=True)
    billdate = models.DateField(null=True)
    amt_claimed = models.DecimalField(max_digits=15, decimal_places=2, null=True)
    firm_name = models.CharField(max_length=100, null=True)
    caorsono = models.CharField(max_length=50, null=True)
    caorsodate = models.DateField(null=True)
    ncsTransactionId = models.CharField(max_length=50, null=True)
    ncsOldTransactionId = models.CharField(max_length=50, null=True)
    pfms_transaction = models.CharField(max_length=50, null=True)
    pfms_sanctionId = models.CharField(max_length=50, null=True)
    flag = models.CharField(max_length=10, null=True)
    remarks = models.TextField(null=True)
    majhd = models.CharField(max_length=50, null=True)
    grantno1 = models.IntegerField(null=True)
    majhd_desc = models.CharField(max_length=100, null=True)
    submajhdid = models.CharField(max_length=50, null=True)
    submajhd = models.CharField(max_length=100, null=True)
    submajhd_desc = models.CharField(max_length=100, null=True)
    minhdid = models.CharField(max_length=50, null=True)
    minorhd = models.CharField(max_length=100, null=True)
    minorhd_desc = models.CharField(max_length=100, null=True)
    subhdid = models.CharField(max_length=50, null=True)
    sub_head = models.CharField(max_length=100, null=True)
    sub_head_desc = models.CharField(max_length=100, null=True)
    dethdid = models.CharField(max_length=50, null=True)
    detailhd = models.CharField(max_length=100, null=True)
    detailhd_desc = models.CharField(max_length=100, null=True)
    chid = models.CharField(max_length=50, null=True)
    ch = models.CharField(max_length=50, null=True)
    ch_desc = models.CharField(max_length=100, null=True)
    rc = models.CharField(max_length=50, null=True)

   

  

    class Meta:
        db_table = 'master_all'  # Use the existing table name
        managed = False  # Since the table is already created, avoid migrations


####__________________________

class BudgetData(models.Model):
    bud_majhdid = models.IntegerField(primary_key=True)  # Set a primary key
    budmajhdid = models.IntegerField()
    dgid = models.IntegerField()
    budyr = models.IntegerField()
    vbe = models.DecimalField(max_digits=15, decimal_places=2)
    cbe = models.DecimalField(max_digits=15, decimal_places=2)
    vre = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True)
    cre = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True)
    vma = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True)
    cma = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True)
    audit = models.CharField(max_length=50, null=True, blank=True)
    EntryTime = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "bud_majhd2425"  # Ensure the table name matches
        managed = False  # Since the table is already created, avoid migrations

    def __str__(self):
        return f"{self.bud_majhdid} - {self.budmajhdid}"


from django.contrib.auth.models import AbstractUser, Group, Permission
from django.db import models

class UserDetails(AbstractUser):
    password = models.CharField(max_length=128)  # Password will be hashed
    last_login = models.DateTimeField(auto_now=True)
    register_date = models.DateField(auto_now_add=True)

    groups = models.ManyToManyField(
        Group,
        related_name="userdetails_groups",  # Avoid conflicts with `auth.User.groups`
        blank=True
    )
    user_permissions = models.ManyToManyField(
        Permission,
        related_name="userdetails_permissions",  # Avoid conflicts with `auth.User.user_permissions`
        blank=True
    )

    class Meta:
        db_table = 'user_details'

    def __str__(self):
        return self.username
