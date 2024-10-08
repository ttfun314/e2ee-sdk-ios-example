// your_rust_library.h
#ifndef YOUR_RUST_LIBRARY_H
#define YOUR_RUST_LIBRARY_H

#include <stdint.h>
// Struct to hold the RSA key pair (public and private keys)
typedef struct
{
    const char *private_key;
    const char *public_key;
} RSAKeyPair;

// FFI function to generate RSA keys of a given size
RSAKeyPair generate_keys_ffi(uint32_t key_size);
const char *encrypt_ffi(const char *msg, const char *public_key);
const char *decrypt_ffi(const char *cipher, const char *private_key);
void free_c_string(char *s);

#endif
