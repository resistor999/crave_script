rm -rf .repo/local_manifests

# Do repo init for rom that we want to build.
repo init -u https://github.com/BuildBots-Den/manifest_spark -b pyro-next --depth=1 --no-repo-verify -g default,-mips,-darwin,-notdefault

# Do remove here before repo sync.
rm -rf hardware
rm -rf vendor
rm -rf system
rm -rf kernel
rm -rf device
rm -rf packages
rm -rf prebuilts/clang/host/linux-x86
rm -rf prebuilts
rm -rf out/host

# Clone our local manifest.
git clone https://github.com/Night-Raids-Reborn/local_manifest --depth 1 -b 13-n .repo/local_manifests

# Let's sync!
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune

# Do remove here after repo sync.
rm -rf packages/resources/devicesettings
rm -rf vendor/qcom/opensource/vibrator
rm -rf packages/providers/DownloadProvider
rm -rf hardware/xiaomi

# Do clone here after repo sync.
git clone https://github.com/PixelExperience/packages_resources_devicesettings -b thirteen packages/resources/devicesettings
git clone https://github.com/Night-Raids-Reborn/android_vendor_qcom_opensource_vibrator -b thirteen vendor/qcom/opensource/vibrator
git clone https://github.com/ArrowOS/android_packages_providers_DownloadProvider -b arrow-13.1 packages/providers/DownloadProvider
git clone https://github.com/LineageOS/android_hardware_xiaomi -b lineage-20 hardware/xiaomi
    
# Define timezone
export TZ=Asia/Jakarta

# Let's start build!
. build/envsetup.sh
lunch spark_citrus-userdebug
mka bacon
