rm -rf .repo/local_manifests

# Do repo init for rom that we want to build.
repo init -u https://github.com/AOSPA/manifest -b topaz --depth=1 --no-repo-verify -g default,-mips,-darwin,-notdefault

# Remove tree before cloning our manifest.
rm -rf device/xiaomi
rm -rf vendor/xiaomi
rm -rf kernel/xiaomi

# Do remove here before repo sync.
rm -rf prebuilts/clang/host/linux-x86
rm -rf hardware/qcom/display.git
rm -rf hardware/qcom/gps
rm -rf hardware/qcom/media
rm -rf hardware/xiaomi
rm -rf vendor/qcom/opensource/audio-hal/primary-hal
rm -rf prebuilts/clang/host/linux-x86

# Clone our local manifest.
git clone https://github.com/Night-Raids-Reborn/local_manifest --depth 1 -b 13-topaz .repo/local_manifests

# Let's sync!
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune
    
# Define timezone
export TZ=Asia/Jakarta

# Let's start build!
bash rom-build.sh citrus -t userdebug -c
