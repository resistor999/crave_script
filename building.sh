rm -rf .repo/local_manifests

# Do repo init for rom that we want to build.
repo init --depth=1 --no-repo-verify -u https://github.com/AOSPA/manifest -b topaz -g default,-mips,-darwin,-notdefault

# Remove tree before cloning our manifest.
rm -rf device/xiaomi
rm -rf vendor/xiaomi
rm -rf kernel/xiaomi

# Clone our local manifest.
git clone https://github.com/Night-Raids-Reborn/local_manifest --depth 1 -b 13-topaz .repo/local_manifests

# Let's sync!
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
    
# Define timezone
export TZ=Asia/Jakarta

# Let's start build!
bash rom-build.sh citrus -t userdebug
